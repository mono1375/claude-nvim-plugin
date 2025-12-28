#!/bin/bash
# Update script for Claude Neovim Plugin

set -e

echo "🔄 Updating Claude Neovim Plugin..."
echo ""

# Backup existing files
if [ -f ~/.config/nvim/lua/claude-mcp/init.lua ]; then
    cp ~/.config/nvim/lua/claude-mcp/init.lua ~/.config/nvim/lua/claude-mcp/init.lua.backup
    echo "✅ Backed up existing plugin to init.lua.backup"
fi

# Copy new files
cp plugin/init.lua ~/.config/nvim/lua/claude-mcp/init.lua
echo "✅ Updated plugin code"

cp plugin-config.lua ~/.config/nvim/lua/plugins/claude-mcp.lua
echo "✅ Updated config"

echo ""
echo "✨ Update complete!"
echo ""
echo "Restart Neovim or run :Lazy reload claude-mcp to apply changes"
echo ""
