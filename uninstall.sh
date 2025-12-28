#!/bin/bash
# Uninstallation script for Claude Neovim Plugin

set -e

echo "🗑️  Uninstalling Claude Neovim Plugin..."
echo ""

read -p "Are you sure you want to uninstall? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

# Remove plugin files
if [ -d ~/.config/nvim/lua/claude-mcp ]; then
    rm -rf ~/.config/nvim/lua/claude-mcp
    echo "✅ Removed ~/.config/nvim/lua/claude-mcp"
fi

if [ -f ~/.config/nvim/lua/plugins/claude-mcp.lua ]; then
    rm ~/.config/nvim/lua/plugins/claude-mcp.lua
    echo "✅ Removed ~/.config/nvim/lua/plugins/claude-mcp.lua"
fi

echo ""
echo "✨ Uninstallation complete!"
echo ""
echo "Restart Neovim to complete the process."
echo "The plugin source files in ~/Documents/Gemini Projects/tools/claude-nvim-plugin remain intact."
echo ""
