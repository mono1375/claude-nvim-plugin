local M = {}

-- Ask Claude a question via CLI
function M.ask(question)
  if not question or question == "" then
    question = vim.fn.input("Ask Claude: ")
    if question == "" then
      return
    end
  end

  -- Run claude CLI with the question
  vim.notify("Asking Claude...", vim.log.levels.INFO)

  vim.fn.jobstart({ "claude", "--print", question }, {
    on_stdout = function(_, data)
      if data and #data > 0 then
        -- Open result in new buffer
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
        vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
        vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

        -- Filter empty lines and set content
        local lines = vim.tbl_filter(function(line)
          return line ~= ""
        end, data)

        if #lines > 0 then
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          vim.api.nvim_command("vsplit")
          vim.api.nvim_win_set_buf(0, buf)
        end
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        for _, line in ipairs(data) do
          if line ~= "" then
            vim.notify("Claude: " .. line, vim.log.levels.WARN)
          end
        end
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        vim.notify("Claude exited with code: " .. exit_code, vim.log.levels.ERROR)
      end
    end,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

-- Get code suggestions for current buffer
function M.get_suggestion()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local content = table.concat(lines, "\n")
  local filetype = vim.bo.filetype

  local cursor = vim.api.nvim_win_get_cursor(0)
  local prompt = string.format(
    "I'm working on a %s file. Here's my code:\n\n```%s\n%s\n```\n\nI'm at line %d. What suggestions do you have to improve this code or continue from here?",
    filetype,
    filetype,
    content,
    cursor[1]
  )

  M.ask(prompt)
end

-- Explain selected code
function M.explain_selection(question)
  -- Get visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
  local selection = table.concat(lines, "\n")
  local filetype = vim.bo.filetype

  if not question or question == "" then
    question = vim.fn.input("Ask about selection: ")
    if question == "" then
      question = "Explain what this code does"
    end
  end

  local prompt = string.format(
    "%s\n\n```%s\n%s\n```",
    question,
    filetype,
    selection
  )

  M.ask(prompt)
end

-- Review current file
function M.review_file()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local content = table.concat(lines, "\n")
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%:t")

  local prompt = string.format(
    "Please review this %s file (%s) and provide suggestions for improvements, potential bugs, or best practices:\n\n```%s\n%s\n```",
    filetype,
    filename,
    filetype,
    content
  )

  M.ask(prompt)
end

-- Generate code from description
function M.generate_code(description)
  if not description or description == "" then
    description = vim.fn.input("Describe what code to generate: ")
    if description == "" then
      return
    end
  end

  local filetype = vim.bo.filetype
  local prompt = string.format(
    "Generate %s code for: %s\n\nProvide just the code, no explanations.",
    filetype,
    description
  )

  M.ask(prompt)
end

-- Setup plugin
function M.setup(opts)
  opts = opts or {}

  -- Create commands
  vim.api.nvim_create_user_command("ClaudeAsk", function(cmd_opts)
    M.ask(cmd_opts.args)
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("ClaudeSuggest", M.get_suggestion, {})

  vim.api.nvim_create_user_command("ClaudeReview", M.review_file, {})

  vim.api.nvim_create_user_command("ClaudeGenerate", function(cmd_opts)
    M.generate_code(cmd_opts.args)
  end, { nargs = "?" })

  -- Create keymaps if configured
  if opts.keymaps ~= false then
    vim.keymap.set("n", "<leader>ca", function()
      M.ask()
    end, { desc = "Claude: Ask question" })

    vim.keymap.set("n", "<leader>cs", M.get_suggestion, { desc = "Claude: Get suggestion" })

    vim.keymap.set("n", "<leader>cr", M.review_file, { desc = "Claude: Review file" })

    vim.keymap.set("n", "<leader>cg", function()
      M.generate_code()
    end, { desc = "Claude: Generate code" })

    vim.keymap.set("v", "<leader>ce", function()
      M.explain_selection()
    end, { desc = "Claude: Explain selection" })
  end

  vim.notify("Claude integration loaded (using CLI)", vim.log.levels.INFO)
end

return M
