local M = {}

-- Plugin state
M.state = {
  current_provider = "claude",
  suggestion_ns = vim.api.nvim_create_namespace("ai_suggestions"),
  diff_ns = vim.api.nvim_create_namespace("ai_diff"),
  active_suggestion = nil,
  inline_enabled = true,
}

-- Load configuration
function M.load_config()
  local config_path = vim.fn.expand("~/Documents/Gemini Projects/tools/ai-assistant/config.yaml")

  -- Simple YAML parser for our config
  local config = {
    default_provider = "claude",
    features = {
      inline_suggestions = true,
      auto_trigger = true,
      delay_ms = 500,
    }
  }

  local f = io.open(config_path, "r")
  if f then
    for line in f:lines() do
      if line:match("^default_provider:") then
        config.default_provider = line:match(":%s*(.+)")
      end
    end
    f:close()
  end

  M.state.current_provider = config.default_provider
  return config
end

-- Get AI provider command
function M.get_provider_command(provider)
  local providers = {
    claude = { cmd = "claude", args = { "--print" } },
    gemini = { cmd = "gemini", args = {} },
    copilot = { cmd = "gh", args = { "copilot", "suggest" } },
  }
  return providers[provider] or providers.claude
end

-- Get current file context
function M.get_context()
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local filetype = vim.bo.filetype

  return {
    lines = lines,
    content = table.concat(lines, "\n"),
    cursor_line = cursor[1],
    cursor_col = cursor[2],
    filetype = filetype,
    filename = vim.fn.expand("%:t"),
  }
end

-- Get git diff for current file
function M.get_git_diff()
  local filepath = vim.fn.expand("%:p")

  -- Check if file is in git repo
  local in_git = vim.fn.system("git -C " .. vim.fn.shellescape(vim.fn.expand("%:p:h")) .. " rev-parse 2>/dev/null")
  if vim.v.shell_error ~= 0 then
    return nil
  end

  -- Get diff
  local diff = vim.fn.system("git diff " .. vim.fn.shellescape(filepath))
  return diff
end

-- Generate AI suggestion
function M.generate_suggestion(prompt)
  local provider = M.get_provider_command(M.state.current_provider)
  local cmd = { provider.cmd }
  vim.list_extend(cmd, provider.args)
  table.insert(cmd, prompt)

  local result = {}

  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      if data then
        vim.list_extend(result, data)
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        M.apply_suggestion(table.concat(result, "\n"))
      end
    end,
    stdout_buffered = true,
  })
end

-- Request inline suggestion
function M.request_inline_suggestion()
  if not M.state.inline_enabled then
    return
  end

  local ctx = M.get_context()

  -- Build prompt for AI
  local prompt = string.format([[
I'm working on a %s file. Here's my current code:

```%s
%s
```

I'm at line %d. Provide a code suggestion to improve or continue from here.
Return ONLY the suggested code changes, no explanations.
Format: Show what lines to change and the new code.
]], ctx.filetype, ctx.filetype, ctx.content, ctx.cursor_line)

  M.generate_suggestion(prompt)
end

-- Show side-by-side diff view
function M.show_diff_view(original, suggested)
  -- Create a new buffer for diff view
  local diff_buf = vim.api.nvim_create_buf(false, true)

  -- Split window vertically
  vim.cmd("vsplit")
  vim.api.nvim_win_set_buf(0, diff_buf)

  -- Set buffer options
  vim.api.nvim_buf_set_option(diff_buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(diff_buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_name(diff_buf, "AI Suggestion (diff)")

  -- Create diff content
  local diff_lines = {}
  table.insert(diff_lines, "=== ORIGINAL ===")
  table.insert(diff_lines, "")
  for _, line in ipairs(vim.split(original, "\n")) do
    table.insert(diff_lines, "- " .. line)
  end
  table.insert(diff_lines, "")
  table.insert(diff_lines, "=== SUGGESTED ===")
  table.insert(diff_lines, "")
  for _, line in ipairs(vim.split(suggested, "\n")) do
    table.insert(diff_lines, "+ " .. line)
  end

  vim.api.nvim_buf_set_lines(diff_buf, 0, -1, false, diff_lines)

  -- Enable diff mode
  vim.cmd("windo diffthis")

  -- Add keymaps for accepting/rejecting
  vim.api.nvim_buf_set_keymap(diff_buf, "n", "<leader>aa", ":lua require('ai-assistant').accept_suggestion()<CR>",
    { noremap = true, silent = true, desc = "Accept AI suggestion" })
  vim.api.nvim_buf_set_keymap(diff_buf, "n", "<leader>ar", ":lua require('ai-assistant').reject_suggestion()<CR>",
    { noremap = true, silent = true, desc = "Reject AI suggestion" })
end

-- Show git-style diff with highlighting
function M.show_git_diff()
  local diff = M.get_git_diff()

  if not diff or diff == "" then
    vim.notify("No git changes to show", vim.log.levels.INFO)
    return
  end

  -- Create diff buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.cmd("vsplit")
  vim.api.nvim_win_set_buf(0, buf)

  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "filetype", "diff")
  vim.api.nvim_buf_set_name(buf, "Git Diff")

  local diff_lines = vim.split(diff, "\n")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, diff_lines)

  -- Highlight diff lines
  for i, line in ipairs(diff_lines) do
    if line:match("^%-") then
      vim.api.nvim_buf_add_highlight(buf, M.state.diff_ns, "DiffDelete", i - 1, 0, -1)
    elseif line:match("^%+") then
      vim.api.nvim_buf_add_highlight(buf, M.state.diff_ns, "DiffAdd", i - 1, 0, -1)
    elseif line:match("^@@") then
      vim.api.nvim_buf_add_highlight(buf, M.state.diff_ns, "DiffChange", i - 1, 0, -1)
    end
  end
end

-- Apply suggestion to current buffer
function M.apply_suggestion(suggestion)
  M.state.active_suggestion = suggestion

  local ctx = M.get_context()
  M.show_diff_view(ctx.content, suggestion)
end

-- Accept the suggestion
function M.accept_suggestion()
  if not M.state.active_suggestion then
    vim.notify("No active suggestion", vim.log.levels.WARN)
    return
  end

  -- Close diff windows
  vim.cmd("diffoff!")
  vim.cmd("close")

  -- Apply changes to original buffer
  local lines = vim.split(M.state.active_suggestion, "\n")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  vim.notify("AI suggestion applied!", vim.log.levels.INFO)
  M.state.active_suggestion = nil

  -- Show git diff of what changed
  vim.defer_fn(function()
    M.show_git_diff()
  end, 100)
end

-- Reject the suggestion
function M.reject_suggestion()
  vim.cmd("diffoff!")
  vim.cmd("close")
  vim.notify("AI suggestion rejected", vim.log.levels.INFO)
  M.state.active_suggestion = nil
end

-- Inline suggestion with virtual text
function M.show_inline_virtual_text(suggestion)
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = cursor[1] - 1

  -- Clear previous suggestions
  vim.api.nvim_buf_clear_namespace(buf, M.state.suggestion_ns, 0, -1)

  -- Show suggestion as virtual text (ghost text)
  local virt_text = {}
  local suggestion_lines = vim.split(suggestion, "\n")

  for i, text in ipairs(suggestion_lines) do
    if i == 1 then
      table.insert(virt_text, { text, "Comment" })
    end
  end

  vim.api.nvim_buf_set_extmark(buf, M.state.suggestion_ns, line, 0, {
    virt_text = virt_text,
    virt_text_pos = "eol",
    hl_mode = "combine",
  })

  -- Store suggestion for acceptance
  M.state.active_suggestion = suggestion
end

-- Request AI code refactor with diff
function M.refactor_selection()
  -- Get visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
  local selection = table.concat(lines, "\n")
  local filetype = vim.bo.filetype

  if selection == "" then
    vim.notify("No selection to refactor", vim.log.levels.WARN)
    return
  end

  local prompt = string.format([[
Refactor this %s code to improve quality, readability, and performance:

```%s
%s
```

Return ONLY the refactored code, no explanations.
]], filetype, filetype, selection)

  M.generate_suggestion(prompt)
end

-- Setup plugin
function M.setup(opts)
  opts = opts or {}

  -- Load config
  local config = M.load_config()

  -- Create commands
  vim.api.nvim_create_user_command("AISuggest", M.request_inline_suggestion, {})
  vim.api.nvim_create_user_command("AIRefactor", M.refactor_selection, { range = true })
  vim.api.nvim_create_user_command("AIAccept", M.accept_suggestion, {})
  vim.api.nvim_create_user_command("AIReject", M.reject_suggestion, {})
  vim.api.nvim_create_user_command("AIGitDiff", M.show_git_diff, {})
  vim.api.nvim_create_user_command("AISwitch", function(cmd_opts)
    M.state.current_provider = cmd_opts.args
    vim.notify("Switched to " .. cmd_opts.args, vim.log.levels.INFO)
  end, { nargs = 1 })

  -- Create keymaps
  if opts.keymaps ~= false then
    -- Inline suggestion
    vim.keymap.set("n", "<C-Space>", M.request_inline_suggestion, { desc = "AI: Request suggestion" })

    -- Refactor selection
    vim.keymap.set("v", "<leader>ar", M.refactor_selection, { desc = "AI: Refactor selection" })

    -- Accept/Reject
    vim.keymap.set("n", "<leader>aa", M.accept_suggestion, { desc = "AI: Accept suggestion" })
    vim.keymap.set("n", "<leader>ax", M.reject_suggestion, { desc = "AI: Reject suggestion" })

    -- Show git diff
    vim.keymap.set("n", "<leader>ad", M.show_git_diff, { desc = "AI: Show git diff" })
  end

  -- Auto-trigger on cursor hold (optional)
  if config.features.auto_trigger then
    vim.api.nvim_create_autocmd({ "CursorHoldI", "CursorHold" }, {
      callback = function()
        if M.state.inline_enabled then
          M.request_inline_suggestion()
        end
      end,
    })
    vim.opt.updatetime = config.features.delay_ms or 500
  end

  vim.notify("AI Assistant loaded - Provider: " .. M.state.current_provider, vim.log.levels.INFO)
end

-- Toggle inline suggestions
function M.toggle_inline()
  M.state.inline_enabled = not M.state.inline_enabled
  local status = M.state.inline_enabled and "enabled" or "disabled"
  vim.notify("Inline suggestions " .. status, vim.log.levels.INFO)
end

return M
