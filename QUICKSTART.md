# Quick Start - Claude Neovim Plugin

**Get up and running in 2 minutes!**

## Installation (30 seconds)

```bash
cd ~/Documents/"Gemini Projects"/tools/claude-nvim-plugin
./install.sh
```

## First Use (1 minute)

```bash
# Open Neovim
nvim

# Press Space, then c, then a
<Space>ca

# Type: What is Python?
# Press Enter

# Response appears in split! 🎉
```

## Essential Shortcuts

| Key | Action |
|-----|--------|
| `<Space>ca` | Ask question |
| `<Space>cs` | Get suggestion |
| `<Space>cr` | Review file |
| `<Space>ce` | Explain (visual mode) |

## Try It Now

1. **Ask a question:**
   ```
   <Space>ca → "What is recursion?"
   ```

2. **Get code help:**
   ```
   Open test.py
   <Space>cs
   ```

3. **Explain code:**
   ```
   Select code with 'v'
   <Space>ce
   ```

## Next Steps

- Read full manual: `cat MANUAL.md`
- See examples: `cat examples/workflow.md`
- Configure: Edit `~/.config/nvim/lua/plugins/claude-mcp.lua`

## Troubleshooting

**Nothing happens?**
```bash
claude --print "test"
# Should work in terminal first
```

**Not installed?**
```bash
./install.sh
nvim  # Restart
```

---

**You're ready! Open Neovim and press `<Space>ca` to start.** 🚀
