return {
  -- Custom Claude CLI integration
  {
    dir = "~/.config/nvim/lua/claude-mcp",
    name = "claude-mcp",
    lazy = false,
    priority = 1000,
    config = function()
      require("claude-mcp").setup({
        keymaps = true, -- Enable default keymaps
      })
    end,
  },
}
