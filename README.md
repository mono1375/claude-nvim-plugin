# Claude Neovim Plugin

A custom Neovim plugin that integrates Claude Code CLI into LazyVim, providing AI assistance directly in your editor.

## Features

- ✅ Ask Claude questions from Neovim
- ✅ Get code suggestions for current file
- ✅ Explain selected code
- ✅ Review entire files
- ✅ Generate code from descriptions
- ✅ Uses existing Claude CLI authentication (no API key needed!)

## Installation

### Prerequisites

1. **Neovim** (v0.9+)
2. **LazyVim** installed
3. **Claude Code CLI** installed and authenticated

Verify Claude is installed:
```bash
claude --version
```

### Install Steps

1. **Copy plugin files:**
```bash
cp -r plugin/* ~/.config/nvim/lua/claude-mcp/
cp plugin-config.lua ~/.config/nvim/lua/plugins/claude-mcp.lua
```

2. **Restart Neovim:**
```bash
nvim
```

You should see: "Claude integration loaded (using CLI)"

3. **Test it:**
```
:ClaudeAsk What is Lua?
```

## Usage

### Commands

| Command | Description | Example |
|---------|-------------|---------|
| `:ClaudeAsk [question]` | Ask Claude anything | `:ClaudeAsk How do I reverse a string?` |
| `:ClaudeSuggest` | Get suggestions for current file | `:ClaudeSuggest` |
| `:ClaudeReview` | Review current file | `:ClaudeReview` |
| `:ClaudeGenerate [desc]` | Generate code | `:ClaudeGenerate fibonacci function` |

### Keybindings

| Keymap | Mode | Action |
|--------|------|--------|
| `<Space>ca` | Normal | Ask Claude a question |
| `<Space>cs` | Normal | Get code suggestions |
| `<Space>cr` | Normal | Review current file |
| `<Space>cg` | Normal | Generate code |
| `<Space>ce` | Visual | Explain selected code |

### Workflow Examples

#### 1. Ask a Question
```
Press: <Space>ca
Type: "How do I read a file in Python?"
Press: Enter
```
Response appears in a vertical split.

#### 2. Get Code Suggestions
```
1. Open a code file
2. Position cursor where you want help
3. Press: <Space>cs
```
Claude analyzes your code and provides suggestions.

#### 3. Explain Code
```
1. Press 'v' to enter visual mode
2. Select code with j/k
3. Press: <Space>ce
4. Type question or press Enter for default
```
Claude explains the selected code.

#### 4. Review File
```
Press: <Space>cr
```
Claude reviews your entire file for improvements.

#### 5. Generate Code
```
Press: <Space>cg
Type: "Create a function to validate email addresses"
Press: Enter
```

## How It Works

```
Neovim Plugin → claude --print "question" → Claude API → Response in vsplit
```

- Uses `claude --print` command for non-interactive responses
- Leverages your existing Claude Code CLI authentication
- No additional API key or billing required
- Responses open in vertical splits (close with `:q`)

## Configuration

The plugin is configured in `~/.config/nvim/lua/plugins/claude-mcp.lua`:

```lua
return {
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
```

### Disable Keymaps

To disable default keymaps and define your own:

```lua
require("claude-mcp").setup({
  keymaps = false,
})

-- Then define your own:
vim.keymap.set("n", "<leader>ai", require("claude-mcp").ask)
```

## Troubleshooting

### Commands don't work
**Check Claude CLI is installed:**
```bash
which claude
# Should output: /home/deck/.local/bin/claude
```

**Test manually:**
```bash
claude --print "test"
```

**Check authentication:**
```bash
claude
# Follow login prompts if needed
```

### No response appears
**Check Neovim messages:**
```
:messages
```

Look for errors from Claude.

### Permission errors
The `--print` flag automatically skips workspace trust dialogs. This is safe for your personal code.

## File Structure

```
~/Documents/Gemini Projects/tools/claude-nvim-plugin/
├── README.md                  # This file
├── MANUAL.md                  # Detailed user manual
├── INSTALL.md                 # Installation guide
├── plugin/
│   └── init.lua              # Main plugin code
├── plugin-config.lua          # LazyVim plugin config
├── test.lua                   # Test file
└── examples/                  # Usage examples
    └── workflow.md
```

## Differences from Copilot

| Feature | This Plugin | GitHub Copilot |
|---------|-------------|----------------|
| Inline suggestions | ❌ | ✅ |
| Question/Answer | ✅ | ❌ |
| Code review | ✅ | ❌ |
| Explanations | ✅ | Limited |
| Authentication | Claude CLI | GitHub account |
| Cost | Included with Claude | Separate subscription |

This plugin is more like a **coding assistant** than autocomplete.

## Tips

- Close response splits quickly with `:q`
- Use `:ClaudeReview` before committing code
- Ask follow-up questions with `<Space>ca`
- Select confusing code and press `<Space>ce` to understand it
- Generate boilerplate with `<Space>cg`

## Requirements

- Neovim 0.9+
- LazyVim
- Claude Code CLI (authenticated)

## License

MIT License - Free to use and modify

## Support

For issues or questions:
1. Check `:messages` in Neovim for errors
2. Test `claude --print "test"` in terminal
3. Create a bead: `bd create "Issue with Claude Neovim plugin"`

## Credits

Created for integrating Claude Code CLI with Neovim/LazyVim.
