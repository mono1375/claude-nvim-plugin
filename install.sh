#!/bin/bash
# Installation script for Claude Neovim Plugin

set -e

echo "🚀 Installing Claude Neovim Plugin..."
echo ""

# Check prerequisites
echo "Checking prerequisites..."

# Check Neovim
if ! command -v nvim &> /dev/null; then
    echo "❌ Neovim not found. Please install Neovim first."
    exit 1
fi
echo "✅ Neovim found: $(nvim --version | head -1)"

# Check Claude CLI
if ! command -v claude &> /dev/null; then
    echo "❌ Claude CLI not found. Please install Claude Code first."
    echo "   Run: curl -fsSL https://raw.githubusercontent.com/anthropics/claude-code/main/install.sh | bash"
    exit 1
fi
echo "✅ Claude CLI found: $(claude --version)"

# Check LazyVim
if [ ! -f ~/.config/nvim/lua/config/lazy.lua ]; then
    echo "⚠️  Warning: LazyVim config not found. This plugin is designed for LazyVim."
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo ""
echo "Installing plugin files..."

# Create directories
mkdir -p ~/.config/nvim/lua/claude-mcp
mkdir -p ~/.config/nvim/lua/plugins

# Copy plugin files
cp plugin/init.lua ~/.config/nvim/lua/claude-mcp/init.lua
echo "✅ Copied plugin code to ~/.config/nvim/lua/claude-mcp/init.lua"

cp plugin-config.lua ~/.config/nvim/lua/plugins/claude-mcp.lua
echo "✅ Copied config to ~/.config/nvim/lua/plugins/claude-mcp.lua"

echo ""
echo "✨ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Restart Neovim: nvim"
echo "2. Look for: 'Claude integration loaded (using CLI)'"
echo "3. Test it: Press <Space>ca and ask a question"
echo ""
echo "📖 Read the manual: cat MANUAL.md"
echo "❓ Need help? Check INSTALL.md for troubleshooting"
echo ""
echo "Happy coding with Claude! 🎉"
