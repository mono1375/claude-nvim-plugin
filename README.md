# Claude Neovim Plugin - Multi-AI Assistant

A comprehensive Neovim plugin and CLI toolset that integrates multiple AI providers (Claude, Gemini, GitHub Copilot, OpenAI) with inline code suggestions, side-by-side diff views, and git integration.

## 🌟 Features

### Neovim Features
- ✅ **Ask Claude questions** from Neovim
- ✅ **Code suggestions** - Get AI-powered code improvements
- ✅ **Review files** - Full code review with suggestions
- ✅ **Explain code** - Understand complex code sections
- ✅ **Generate code** - Create code from descriptions
- ✅ **Inline Suggestions** - GitHub Copilot-style code suggestions
- ✅ **Side-by-Side Diff** - Visual comparison of original vs AI suggestion
- ✅ **Git Integration** - Shows git diff after applying changes
- ✅ **Multi-Provider** - Switch between Claude, Gemini, Copilot, OpenAI

### CLI Features
- ✅ **Provider Switching** - Easy switching between AI providers
- ✅ **Universal `ai` command** - One command for all providers
- ✅ **Provider detection** - Auto-detects available AIs

## 📦 Installation

### Quick Install

```bash
cd ~/Documents/"Gemini Projects"/tools/claude-nvim-plugin
./install.sh
```

This installs:
- Neovim plugin (original features)
- CLI tools (`ai`, `ai-switch`)
- Multi-provider support

### Manual Install

```bash
# 1. Install CLI tools
cp cli/ai-switch ~/.local/bin/
cp cli/ai ~/.local/bin/
chmod +x ~/.local/bin/ai{,-switch}

# 2. Install Neovim plugin
cp plugin-config.lua ~/.config/nvim/lua/plugins/claude-nvim-plugin.lua

# 3. Restart Neovim
nvim
```

## 🚀 Usage

### CLI Usage

#### Provider Management

```bash
# List available AI providers
ai-switch list

# Switch to different providers
ai-switch switch claude
ai-switch switch gemini
ai-switch switch copilot

# Check current provider
ai-switch current

# Test a provider
ai-switch test gemini
```

#### Universal AI Command

```bash
# Ask questions (uses current provider)
ai "What is Python?"
ai "Explain recursion"
ai "How do I optimize this loop?"
```

### Neovim Usage

#### Original Features (Claude)

| Command | Keymap | Description |
|---------|--------|-------------|
| `:ClaudeAsk [question]` | `<Space>ca` | Ask Claude anything |
| `:ClaudeSuggest` | `<Space>cs` | Get code suggestions |
| `:ClaudeReview` | `<Space>cr` | Review current file |
| `:ClaudeGenerate [desc]` | `<Space>cg` | Generate code |
| Visual + `<Space>ce` | - | Explain selection |

#### New Features (Multi-AI + Inline)

| Command | Keymap | Description |
|---------|--------|-------------|
| `:AISuggest` | `<Ctrl-Space>` | Inline AI suggestion with diff |
| `:AIRefactor` | `<leader>ar` (visual) | Refactor selected code |
| `:AIAccept` | `<leader>aa` | Accept AI suggestion |
| `:AIReject` | `<leader>ax` | Reject suggestion |
| `:AIGitDiff` | `<leader>ad` | Show git diff |
| `:AISwitch <provider>` | - | Switch AI provider |

## 🎯 Workflows

### Workflow 1: Quick Question (Original Feature)

```
1. Press <Space>ca
2. Type your question
3. Response appears in split
```

### Workflow 2: Inline Suggestion (New Feature)

```
1. Position cursor in code
2. Press <Ctrl-Space>
3. AI analyzes and shows side-by-side diff
   ┌────────────────┬────────────────┐
   │   ORIGINAL     │  AI SUGGESTION │
   └────────────────┴────────────────┘
4. Press <leader>aa to accept or <leader>ax to reject
5. See git diff of what changed
```

### Workflow 3: Refactor Code

```
1. Select code in visual mode (v)
2. Press <leader>ar
3. View refactored version in diff view
4. Accept or reject
```

### Workflow 4: Switch Providers

```bash
# In terminal
ai-switch switch gemini

# In Neovim
:AISwitch gemini
# Now all AI commands use Gemini
```

## 📋 Configuration

Edit `~/Documents/Gemini Projects/tools/claude-nvim-plugin/config.yaml`:

```yaml
# Choose your default AI provider
default_provider: claude

providers:
  claude:
    enabled: true
    command: claude
    args: "--print"
    auth: cli  # Uses Claude CLI authentication

  gemini:
    enabled: true
    command: gemini
    auth: env  # Requires GEMINI_API_KEY
    env_var: GEMINI_API_KEY

  copilot:
    enabled: false  # Install: gh extension install github/gh-copilot

  openai:
    enabled: false  # Install: pip install openai

features:
  inline_suggestions: true
  auto_trigger: false
  delay_ms: 500
```

### Set API Keys

```bash
# Gemini
export GEMINI_API_KEY="your-key-here"
echo 'export GEMINI_API_KEY="your-key"' >> ~/.bashrc

# OpenAI
export OPENAI_API_KEY="your-key-here"
echo 'export OPENAI_API_KEY="your-key"' >> ~/.bashrc
```

## 🎨 Side-by-Side Diff View

When requesting inline suggestions:

```
┌─────────────────────────┬─────────────────────────┐
│       ORIGINAL          │     AI SUGGESTION       │
├─────────────────────────┼─────────────────────────┤
│ def calculate(nums):    │ def calculate(nums):    │
│     total = 0           │     """Calculate sum    │
│     for n in nums:      │     of numbers."""      │
│         total += n      │     return sum(nums)    │
│     return total        │                         │
└─────────────────────────┴─────────────────────────┘

        <leader>aa - Accept    <leader>ax - Reject
```

Features:
- **Color-coded** - Red for deletions, green for additions
- **Syntax highlighting** - Preserves language syntax
- **Line-by-line** - Easy comparison
- **Git integration** - Shows final diff after applying

## 🔧 Requirements

### Neovim
- Neovim 0.9+
- LazyVim

### AI Providers (at least one)
- **Claude CLI** ✅ (recommended, no API key)
- **Gemini CLI** ✅ (requires GEMINI_API_KEY)
- **GitHub Copilot** (install: `gh extension install github/gh-copilot`)
- **OpenAI** (install: `pip install openai`)

### System
- Git (for diff features)
- Bash/Zsh

## 📖 All Keybindings

### Original Features
| Key | Mode | Action |
|-----|------|--------|
| `<Space>ca` | Normal | Ask Claude |
| `<Space>cs` | Normal | Get suggestions |
| `<Space>cr` | Normal | Review file |
| `<Space>cg` | Normal | Generate code |
| `<Space>ce` | Visual | Explain selection |

### New Features
| Key | Mode | Action |
|-----|------|--------|
| `<Ctrl-Space>` | Normal | Inline AI suggestion |
| `<leader>ar` | Visual | Refactor selection |
| `<leader>aa` | Normal | Accept suggestion |
| `<leader>ax` | Normal | Reject suggestion |
| `<leader>ad` | Normal | Show git diff |
| `q` | Normal (in diff) | Close diff view |

## 🐛 Troubleshooting

### Plugin Not Loading
```vim
:Lazy reload claude-nvim-plugin
:messages  # Check for errors
```

### Provider Not Working
```bash
ai-switch list  # Check available providers
ai-switch test claude  # Test specific provider
```

### No Suggestions
```vim
:AISuggest  # Trigger manually
:messages   # Check for errors
```

### API Key Issues
```bash
echo $GEMINI_API_KEY  # Verify env var
```

## 📂 Project Structure

```
claude-nvim-plugin/
├── cli/
│   ├── ai-switch           # Provider switcher
│   └── ai                  # Universal AI command
├── plugin/
│   ├── init.lua            # Original Claude plugin
│   └── ai-assistant/       # Multi-AI inline features
│       ├── init.lua
│       └── diff.lua
├── config.yaml             # Multi-provider config
├── plugin-config.lua       # LazyVim config
├── install.sh              # Installer
├── README.md               # This file
├── MANUAL.md               # Detailed guide
├── QUICKSTART.md           # Quick start
└── examples/
    └── workflow.md         # Usage examples
```

## 🎓 Tips

1. **Start with Claude** - No API key needed, works out of the box
2. **Use inline suggestions** - Press `<Ctrl-Space>` for copilot-style help
3. **Review before accepting** - Always check the diff view
4. **Check git diff** - See exactly what changed
5. **Switch providers** - Try different AIs for different tasks
6. **Learn keybindings** - Faster workflow

## 🚀 Quick Start

```bash
# 1. Install
cd ~/Documents/"Gemini Projects"/tools/claude-nvim-plugin
./install.sh

# 2. Try CLI
ai "What is Python?"
ai-switch list

# 3. Try Neovim
nvim test.py
# Press <Ctrl-Space> for inline suggestion
# Press <Space>ca to ask questions
```

## 📝 Changelog

### v2.0.0 - Multi-AI Provider Support
- Added provider switching (`ai-switch`)
- Added universal `ai` command
- Added inline suggestions with diff view
- Added support for Gemini, Copilot, OpenAI
- Added side-by-side diff viewer
- Added git integration for change tracking
- Merged all AI tools into one unified system

### v1.0.0 - Initial Release
- Claude CLI integration
- Ask questions from Neovim
- Code suggestions and review
- Code generation

## 🤝 Contributing

This project is on GitHub: https://github.com/mono1375/claude-nvim-plugin

## 📄 License

MIT License - Free to use and modify

---

**Built with ❤️ for seamless AI-assisted coding across multiple AI providers**
