-- Advanced diff viewer with side-by-side comparison
local M = {}

-- Create a side-by-side diff view
function M.create_side_by_side_diff(original, suggested, opts)
  opts = opts or {}

  -- Save current buffer
  local original_buf = vim.api.nvim_get_current_buf()
  local original_win = vim.api.nvim_get_current_win()

  -- Create buffers for original and suggested
  local left_buf = vim.api.nvim_create_buf(false, true)
  local right_buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer contents
  local original_lines = vim.split(original, "\n")
  local suggested_lines = vim.split(suggested, "\n")

  vim.api.nvim_buf_set_lines(left_buf, 0, -1, false, original_lines)
  vim.api.nvim_buf_set_lines(right_buf, 0, -1, false, suggested_lines)

  -- Set buffer options
  for _, buf in ipairs({ left_buf, right_buf }) do
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(buf, "swapfile", false)
    vim.api.nvim_buf_set_option(buf, "filetype", vim.bo[original_buf].filetype)
  end

  vim.api.nvim_buf_set_name(left_buf, "Original")
  vim.api.nvim_buf_set_name(right_buf, "AI Suggestion")

  -- Create layout: close current, split vertical
  vim.cmd("only")  -- Close all other windows
  vim.cmd("vsplit")

  local left_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(left_win, left_buf)

  vim.cmd("wincmd l")
  local right_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(right_win, right_buf)

  -- Enable diff mode
  vim.api.nvim_win_call(left_win, function()
    vim.cmd("diffthis")
  end)
  vim.api.nvim_win_call(right_win, function()
    vim.cmd("diffthis")
  end)

  -- Highlight differences
  M.highlight_changes(left_buf, right_buf, original_lines, suggested_lines)

  -- Add status line
  vim.api.nvim_buf_set_option(left_buf, "statusline", "%#DiffDelete# ORIGINAL %*")
  vim.api.nvim_buf_set_option(right_buf, "statusline", "%#DiffAdd# AI SUGGESTION %*")

  -- Add keymaps for navigation and actions
  local keymap_opts = { noremap = true, silent = true, buffer = right_buf }

  vim.keymap.set("n", "<leader>aa", function()
    M.accept_diff(original_buf, suggested_lines)
  end, vim.tbl_extend("force", keymap_opts, { desc = "Accept AI suggestion" }))

  vim.keymap.set("n", "<leader>ax", function()
    M.reject_diff(original_buf, original_win)
  end, vim.tbl_extend("force", keymap_opts, { desc = "Reject AI suggestion" }))

  vim.keymap.set("n", "q", function()
    M.reject_diff(original_buf, original_win)
  end, vim.tbl_extend("force", keymap_opts, { desc = "Close diff" }))

  -- Show instructions
  vim.notify([[
AI Diff View
  <leader>aa - Accept changes
  <leader>ax - Reject changes
  q          - Close
]], vim.log.levels.INFO)

  return {
    left_buf = left_buf,
    right_buf = right_buf,
    left_win = left_win,
    right_win = right_win,
    original_buf = original_buf,
    original_win = original_win,
  }
end

-- Highlight changes between original and suggested
function M.highlight_changes(left_buf, right_buf, original_lines, suggested_lines)
  local ns = vim.api.nvim_create_namespace("ai_diff_highlight")

  -- Simple line-by-line diff highlighting
  local max_lines = math.max(#original_lines, #suggested_lines)

  for i = 1, max_lines do
    local orig = original_lines[i] or ""
    local sugg = suggested_lines[i] or ""

    if orig ~= sugg then
      -- Highlight changed lines
      if i <= #original_lines then
        vim.api.nvim_buf_add_highlight(left_buf, ns, "DiffDelete", i - 1, 0, -1)
      end
      if i <= #suggested_lines then
        vim.api.nvim_buf_add_highlight(right_buf, ns, "DiffAdd", i - 1, 0, -1)
      end
    end
  end
end

-- Accept the diff and apply changes
function M.accept_diff(original_buf, suggested_lines)
  -- Apply changes to original buffer
  vim.api.nvim_buf_set_lines(original_buf, 0, -1, false, suggested_lines)

  -- Close diff view
  vim.cmd("diffoff!")
  vim.cmd("only")

  vim.notify("✓ AI suggestion applied!", vim.log.levels.INFO)

  -- Show git diff of what changed
  vim.defer_fn(function()
    require("ai-assistant").show_git_diff()
  end, 200)
end

-- Reject the diff and return to original
function M.reject_diff(original_buf, original_win)
  vim.cmd("diffoff!")
  vim.cmd("only")

  -- Return to original buffer
  if vim.api.nvim_buf_is_valid(original_buf) then
    vim.api.nvim_set_current_buf(original_buf)
  end

  vim.notify("✗ AI suggestion rejected", vim.log.levels.INFO)
end

-- Create inline diff markers (like GitHub)
function M.show_inline_diff(buf, changes)
  local ns = vim.api.nvim_create_namespace("ai_inline_diff")

  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  for _, change in ipairs(changes) do
    local line = change.line - 1
    local hl_group = change.type == "add" and "DiffAdd" or "DiffDelete"

    -- Add line highlighting
    vim.api.nvim_buf_add_highlight(buf, ns, hl_group, line, 0, -1)

    -- Add virtual text with change info
    local virt_text = {
      { "  ", hl_group },
      { change.type == "add" and "+" or "-", hl_group },
      { " AI suggestion", "Comment" },
    }

    vim.api.nvim_buf_set_extmark(buf, ns, line, 0, {
      virt_text = virt_text,
      virt_text_pos = "right_align",
    })
  end
end

return M
