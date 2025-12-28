# Installation Guide - Claude Neovim Plugin

## Prerequisites

Before installing, ensure you have:

1. **Neovim 0.9+**
```bash
nvim --version
# NVIM v0.9.0 or higher required
```

2. **LazyVim installed**
```bash
ls ~/.config/nvim/lua/config/lazy.lua
# File should exist
```

3. **Claude Code CLI installed and authenticated**
```bash
claude --version
# Should output: 2.0.76 (Claude Code) or similar
```

If Claude CLI is not installed:
```bash
# Install Claude Code
curl -fsSL https://raw.githubusercontent.com/anthropics/claude-code/main/install.sh | bash

# After install, authenticate
claude
# Follow login prompts
```

## Installation Methods

### Method 1: Automatic Install (Recommended)

Run the install script from this directory:

```bash
cd ~/Documents/"Gemini Projects"/tools/claude-nvim-plugin
./install.sh
```

### Method 2: Manual Install

#### Step 1: Create Plugin Directory

```bash
mkdir -p ~/.config/nvim/lua/claude-mcp
```

#### Step 2: Copy Plugin Files

```bash
# Copy main plugin file
cp ~/Documents/"Gemini Projects"/tools/claude-nvim-plugin/plugin/init.lua \
   ~/.config/nvim/lua/claude-mcp/init.lua

# Copy LazyVim config
cp ~/Documents/"Gemini Projects"/tools/claude-nvim-plugin/plugin-config.lua \
   ~/.config/nvim/lua/plugins/claude-mcp.lua
```

#### Step 3: Restart Neovim

```bash
nvim
```

You should see: **"Claude integration loaded (using CLI)"**

#### Step 4: Test Installation

In Neovim, run:
```vim
:ClaudeAsk What is 2+2?
```

If a vertical split opens with "2+2 = 4", installation was successful!

## Verification

### Check Plugin is Loaded

```vim
:Lazy
" Look for 'claude-mcp' in the list
```

### Check Commands are Available

```vim
:ClaudeAsk
" Should prompt you for a question
```

### Check Keymaps Work

Press `<Space>ca` in normal mode. You should see "Ask Claude:" prompt.

## Troubleshooting Installation

### Problem: Plugin not loading

**Check LazyVim is loading plugins:**
```vim
:Lazy
" Should show list of plugins
```

**Check file exists:**
```bash
ls ~/.config/nvim/lua/plugins/claude-mcp.lua
ls ~/.config/nvim/lua/claude-mcp/init.lua
```

**Reload Neovim:**
```bash
# Close Neovim, then:
nvim
```

---

### Problem: Commands not found

**Symptoms:** `:ClaudeAsk` shows "Not an editor command"

**Solution:**
```vim
:Lazy reload claude-mcp
```

Or restart Neovim completely.

---

### Problem: Claude CLI not working

**Test Claude separately:**
```bash
claude --print "test"
```

**If error "command not found":**
```bash
# Install Claude Code
curl -fsSL https://raw.githubusercontent.com/anthropics/claude-code/main/install.sh | bash

# Add to PATH (if needed)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**If authentication error:**
```bash
claude
# Follow login prompts
```

---

### Problem: Permission errors

The plugin uses `claude --print` which skips workspace trust dialogs. This is safe for your personal code directories.

If you still see permission errors, try running Claude once interactively:
```bash
cd ~/your-project
claude
# Say "yes" to trust the workspace
```

## Uninstallation

To remove the plugin:

```bash
# Remove plugin files
rm -rf ~/.config/nvim/lua/claude-mcp
rm ~/.config/nvim/lua/plugins/claude-mcp.lua

# Restart Neovim
nvim
```

## Updating

To update the plugin:

```bash
# Copy latest files
cd ~/Documents/"Gemini Projects"/tools/claude-nvim-plugin
cp plugin/init.lua ~/.config/nvim/lua/claude-mcp/init.lua
cp plugin-config.lua ~/.config/nvim/lua/plugins/claude-mcp.lua

# Reload in Neovim
:Lazy reload claude-mcp
```

Or use the update script:
```bash
cd ~/Documents/"Gemini Projects"/tools/claude-nvim-plugin
./update.sh
```

## File Locations

After installation, you'll have:

```
~/.config/nvim/
├── lua/
│   ├── claude-mcp/
│   │   └── init.lua              # Main plugin code
│   └── plugins/
│       └── claude-mcp.lua         # LazyVim plugin config
```

The source files remain in:
```
~/Documents/Gemini Projects/tools/claude-nvim-plugin/
├── README.md
├── MANUAL.md
├── INSTALL.md                     # This file
├── plugin/
│   └── init.lua
├── plugin-config.lua
└── install.sh
```

## Next Steps

After installation:

1. **Read the Manual:**
```bash
cat ~/Documents/"Gemini Projects"/tools/claude-nvim-plugin/MANUAL.md
```

2. **Try the Quick Start:**
```bash
nvim
# Then press: <Space>ca
# Ask: "What is Lua?"
```

3. **Test with your code:**
```bash
nvim your-project/app.py
# Press: <Space>cr (review file)
```

## Getting Help

If you encounter issues:

1. Check `:messages` in Neovim
2. Test `claude --print "test"` in terminal
3. Verify files are in correct locations
4. Create a bead: `bd create "Installation issue: [describe problem]"`

---

**Installation complete!** 🎉

Open Neovim and start using Claude with `<Space>ca`
