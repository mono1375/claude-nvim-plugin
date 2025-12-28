# Claude Neovim Plugin - Complete User Manual

## Table of Contents
1. [What This Is](#what-this-is)
2. [Quick Start](#quick-start)
3. [All Commands](#all-commands)
4. [All Keybindings](#all-keybindings)
5. [Step-by-Step Tutorials](#step-by-step-tutorials)
6. [Workflow Examples](#workflow-examples)
7. [Troubleshooting](#troubleshooting)
8. [Advanced Usage](#advanced-usage)

## What This Is

A Neovim plugin that lets you talk to Claude Code directly from your editor. Think of it as having Claude as your pair programming partner.

**Key Benefits:**
- Uses your existing Claude CLI authentication
- No additional API key needed
- No extra billing
- Works with any programming language
- Integrated into your Neovim workflow

**What it does:**
- Answers coding questions
- Reviews your code
- Explains complex code
- Generates code from descriptions
- Provides suggestions

**What it doesn't do:**
- Inline autocomplete (like Copilot)
- Real-time suggestions as you type
- Automatic code completion

## Quick Start

### Installation Check

1. **Verify Claude is installed:**
```bash
claude --version
# Output: 2.0.76 (Claude Code) or similar
```

2. **Verify plugin is installed:**
```bash
ls ~/.config/nvim/lua/claude-mcp/init.lua
# Should exist
```

3. **Start Neovim:**
```bash
nvim
```

Look for message: "Claude integration loaded (using CLI)"

### Your First Question

1. In Neovim, press: `<Space>ca`
2. Type: `What is Lua?`
3. Press: `Enter`
4. Response appears in a vertical split!
5. Close it: `:q`

**Congratulations!** You just used the plugin.

## All Commands

### :ClaudeAsk [question]

Ask Claude any question.

**Usage:**
```vim
:ClaudeAsk How do I read a file in Python?
:ClaudeAsk What's the difference between let and const?
:ClaudeAsk Explain recursion
```

**Without argument:**
```vim
:ClaudeAsk
" Prompts you to enter question
```

**Shortcut:** `<Space>ca`

---

### :ClaudeSuggest

Get AI suggestions for improving your current file.

**Usage:**
1. Open a code file
2. Position cursor anywhere
3. Run: `:ClaudeSuggest`

Claude will:
- Analyze your entire file
- Note your cursor position
- Suggest improvements or next steps

**Shortcut:** `<Space>cs`

---

### :ClaudeReview

Get a full code review of your current file.

**Usage:**
```vim
:ClaudeReview
```

Claude will review for:
- Potential bugs
- Best practices
- Code quality
- Performance issues
- Improvements

**Shortcut:** `<Space>cr`

---

### :ClaudeGenerate [description]

Generate code from a description.

**Usage:**
```vim
:ClaudeGenerate fibonacci function in Python
:ClaudeGenerate email validation regex
:ClaudeGenerate REST API endpoint for user login
```

**Without argument:**
```vim
:ClaudeGenerate
" Prompts you for description
```

**Shortcut:** `<Space>cg`

---

### :ClaudeExplain (Visual Mode)

Explain selected code.

**Usage:**
1. Enter visual mode: `v`
2. Select code: `j/k` to expand
3. Run: `<Space>ce`
4. Enter question or press Enter

**Shortcut:** `<Space>ce` (in visual mode)

## All Keybindings

| Keymap | Mode | Command | Description |
|--------|------|---------|-------------|
| `<Space>ca` | Normal | `:ClaudeAsk` | Ask question |
| `<Space>cs` | Normal | `:ClaudeSuggest` | Get suggestions |
| `<Space>cr` | Normal | `:ClaudeReview` | Review file |
| `<Space>cg` | Normal | `:ClaudeGenerate` | Generate code |
| `<Space>ce` | Visual | - | Explain selection |

**Note:** `<Space>` is typically the leader key in LazyVim.

## Step-by-Step Tutorials

### Tutorial 1: Ask Your First Question

1. Open Neovim: `nvim`
2. Press: `Space` (you'll see leader indicator)
3. Press: `c` then `a`
4. You'll see: `Ask Claude:`
5. Type: `What are the basic Lua data types?`
6. Press: `Enter`
7. Wait 2-5 seconds
8. Response opens in right split!
9. Read the answer
10. Close split: `:q` or `Ctrl-w c`

**Tip:** You can ask follow-up questions anytime with `<Space>ca` again.

---

### Tutorial 2: Get Code Suggestions

1. Create a test Python file:
```bash
nvim test.py
```

2. Add some code:
```python
def calculate_sum(numbers):
    total = 0
    for num in numbers:
        total += num
    return total
```

3. Position cursor in the function
4. Press: `<Space>cs`
5. Claude analyzes and suggests improvements!

**Expected suggestions:**
- Use built-in `sum()` function
- Add type hints
- Handle edge cases
- Add docstring

---

### Tutorial 3: Explain Complex Code

1. Open a file with complex code (or create one)
2. Enter visual mode: Press `v`
3. Select a function:
   - `V` for line-wise selection
   - `j` to move down
   - `k` to move up
4. Press: `<Space>ce`
5. Prompt appears: `Ask about selection:`
6. Type: `Explain this step by step` or just press Enter
7. Claude explains the code!

---

### Tutorial 4: Code Review

1. Open a file you want reviewed:
```bash
nvim myapp.py
```

2. Press: `<Space>cr`
3. Wait for Claude to analyze
4. Get detailed review with:
   - Bug detection
   - Best practice suggestions
   - Code quality feedback
   - Improvement recommendations

---

### Tutorial 5: Generate Code

1. Create a new file:
```bash
nvim utils.py
```

2. Press: `<Space>cg`
3. Prompt: `Describe what code to generate:`
4. Type: `Create a function to validate email addresses using regex`
5. Press: `Enter`
6. Claude generates the code!
7. Copy from split to your file

## Workflow Examples

### Example 1: Learning a New Library

**Scenario:** You're learning FastAPI

1. Create new file: `nvim api.py`
2. Ask: `<Space>ca` → "How do I create a simple FastAPI endpoint?"
3. Claude explains with example
4. Generate code: `<Space>cg` → "Basic FastAPI app with one GET endpoint"
5. Review: `<Space>cr`
6. Ask follow-up: `<Space>ca` → "How do I add POST endpoint?"

---

### Example 2: Debugging

**Scenario:** Code isn't working

1. Select broken code: `v` + movement
2. Explain: `<Space>ce` → "Why isn't this working?"
3. Read Claude's analysis
4. Ask follow-up: `<Space>ca` → "How do I fix it?"
5. Implement fix
6. Review: `<Space>cr`

---

### Example 3: Code Review Before Commit

**Workflow:**

```bash
# 1. Open your modified file
nvim src/app.py

# 2. In Neovim, review it
<Space>cr

# 3. Read Claude's suggestions
# 4. Make improvements
# 5. Review again
<Space>cr

# 6. When satisfied, commit
:q
git add src/app.py
git commit -m "Improved app.py based on AI review"
```

---

### Example 4: Refactoring

1. Open legacy code: `nvim old_code.py`
2. Ask: `<Space>ca` → "How should I refactor this code?"
3. Select a function: `v` + movement
4. Ask: `<Space>ce` → "Suggest a better way to write this"
5. Generate: `<Space>cg` → "Refactored version of [describe function]"
6. Compare old vs new
7. Apply changes

---

### Example 5: Understanding Codebase

**Scenario:** New to a project

1. Open main file: `nvim main.py`
2. Get overview: `<Space>cr`
3. Select confusing part: `v` + movement
4. Explain: `<Space>ce`
5. Ask about architecture: `<Space>ca` → "Explain how this application is structured"
6. Repeat for other files

## Troubleshooting

### Problem: Commands don't execute

**Symptoms:** Press `<Space>ca` but nothing happens

**Solutions:**

1. **Check plugin loaded:**
```vim
:messages
" Look for: "Claude integration loaded (using CLI)"
```

2. **Reload plugin:**
```vim
:Lazy reload claude-mcp
```

3. **Check keymaps:**
```vim
:map <Space>ca
" Should show mapping to claude-mcp.ask
```

---

### Problem: No response from Claude

**Symptoms:** Command runs but no split appears

**Solutions:**

1. **Check messages:**
```vim
:messages
" Look for errors
```

2. **Test Claude CLI manually:**
```bash
claude --print "test"
" Should return a response
```

3. **Check authentication:**
```bash
claude
" If not logged in, follow prompts
```

---

### Problem: Error about workspace trust

**Symptoms:** See permission/trust errors

**Solution:**
The `--print` flag bypasses workspace trust. This is safe for your personal code. No action needed.

---

### Problem: Response is truncated

**Symptoms:** Response cuts off mid-sentence

**Solution:**
This is a Claude API response limit. Try:
- Asking more specific questions
- Breaking complex questions into smaller ones

---

### Problem: Slow responses

**Symptoms:** Takes >10 seconds

**Reasons:**
- Claude API may be busy
- Large file analysis takes time
- Network latency

**Solutions:**
- Wait patiently
- Reduce file size before reviewing
- Ask simpler questions

## Advanced Usage

### Custom Keymaps

Disable defaults and create your own:

Edit `~/.config/nvim/lua/plugins/claude-mcp.lua`:

```lua
require("claude-mcp").setup({
  keymaps = false, -- Disable defaults
})

-- Define your own
vim.keymap.set("n", "<leader>ai", require("claude-mcp").ask)
vim.keymap.set("n", "<leader>as", require("claude-mcp").get_suggestion)
vim.keymap.set("n", "<leader>ar", require("claude-mcp").review_file)
vim.keymap.set("n", "<leader>ag", require("claude-mcp").generate_code)
vim.keymap.set("v", "<leader>ae", require("claude-mcp").explain_selection)
```

### Use in Scripts

Call plugin functions in Lua scripts:

```lua
-- From anywhere in Neovim config
local claude = require("claude-mcp")

-- Ask a question programmatically
claude.ask("What is Lua?")

-- Review current file
claude.review_file()
```

### Integration with Other Plugins

**Example: Add to which-key:**

```lua
local wk = require("which-key")
wk.register({
  ["<leader>c"] = {
    name = "+claude",
    a = { "<cmd>ClaudeAsk<cr>", "Ask" },
    s = { "<cmd>ClaudeSuggest<cr>", "Suggest" },
    r = { "<cmd>ClaudeReview<cr>", "Review" },
    g = { "<cmd>ClaudeGenerate<cr>", "Generate" },
  },
})
```

## Tips & Tricks

### 1. Quick Questions
Ask quick questions without leaving your editor:
```
<Space>ca What's the syntax for list comprehension in Python?
```

### 2. Before Committing
Always review before pushing:
```
<Space>cr  # Review current file
```

### 3. Learning New Concepts
Select unfamiliar code and explain it:
```
v (select) → <Space>ce
```

### 4. Generate Boilerplate
Save time on repetitive code:
```
<Space>cg Create a class for user authentication
```

### 5. Multiple Splits
Keep multiple Claude responses open:
- Don't close splits immediately
- Compare different suggestions
- Close all: `:only`

### 6. Copy from Splits
To copy Claude's response:
1. Navigate to split: `Ctrl-w l`
2. Visual select: `V` + movement
3. Yank: `y`
4. Go back: `Ctrl-w h`
5. Paste: `p`

## Best Practices

1. **Ask Specific Questions**
   - ❌ "Help with code"
   - ✅ "How do I handle errors in async Python functions?"

2. **Review Before Committing**
   - Always `<Space>cr` before `git commit`

3. **Learn as You Go**
   - Use `<Space>ce` on code you don't understand
   - Build your knowledge incrementally

4. **Generate, Then Customize**
   - Use `<Space>cg` for boilerplate
   - Customize the generated code to your needs

5. **Keep Splits Organized**
   - Close splits you're done with: `:q`
   - Use `:only` to close all but current

## Keyboard Shortcuts Summary

```
<Space>ca  → Ask Claude
<Space>cs  → Suggestions
<Space>cr  → Review
<Space>cg  → Generate
<Space>ce  → Explain (visual mode)

Ctrl-w l   → Move to right split
Ctrl-w h   → Move to left split
:q         → Close current split
:only      → Close all other splits
```

## Getting Help

1. **Check messages:** `:messages`
2. **Test CLI:** `claude --print "test"`
3. **Check auth:** `claude`
4. **Create bead:** `bd create "Claude plugin issue: [description]"`
5. **View manual:** `cat ~/Documents/"Gemini Projects"/tools/claude-nvim-plugin/MANUAL.md`

---

**You're ready to use Claude in Neovim!** 🚀
