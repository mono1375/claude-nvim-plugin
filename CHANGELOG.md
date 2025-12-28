# Changelog

All notable changes to the Claude Neovim Plugin will be documented in this file.

## [2.0.0] - 2025-12-27

### Added - Multi-AI Provider Support
- **CLI Tools**:
  - `ai-switch` command for switching between AI providers
  - `ai` universal command that works with all providers
  - Provider auto-detection and status checking

- **Multi-Provider Support**:
  - Claude CLI (existing, no API key needed)
  - Gemini CLI integration (requires GEMINI_API_KEY)
  - GitHub Copilot support (requires extension)
  - OpenAI CLI support (requires API key)

- **Inline Suggestions** (GitHub Copilot-style):
  - Press `<Ctrl-Space>` for AI code suggestions
  - Side-by-side diff view (original vs suggestion)
  - Color-coded highlighting (red/green for changes)
  - Syntax highlighting preservation

- **Advanced Diff Features**:
  - Visual side-by-side comparison
  - Git integration showing what changed
  - Accept/reject keybindings
  - Line-by-line diff highlighting

- **New Commands**:
  - `:AISuggest` - Request inline suggestion
  - `:AIRefactor` - Refactor selected code
  - `:AIAccept` - Accept AI suggestion
  - `:AIReject` - Reject suggestion
  - `:AIGitDiff` - Show git diff
  - `:AISwitch <provider>` - Switch AI provider

- **New Keybindings**:
  - `<Ctrl-Space>` - Inline AI suggestion
  - `<leader>ar` - Refactor selection (visual mode)
  - `<leader>aa` - Accept suggestion
  - `<leader>ax` - Reject suggestion
  - `<leader>ad` - Show git diff
  - `q` - Close diff view

- **Configuration System**:
  - `config.yaml` for provider settings
  - Per-provider configuration
  - Feature toggles (inline suggestions, auto-trigger)

### Changed
- Merged all AI tools into unified claude-nvim-plugin repository
- Updated README with multi-provider documentation
- Enhanced project structure with cli/, plugin/, providers/ directories

### Technical
- Added provider abstraction layer
- Implemented side-by-side diff viewer module
- Git diff integration
- Virtual text support for inline suggestions
- Buffer management for diff views

## [1.0.0] - 2025-12-27

### Added
- Initial release of Claude Neovim Plugin
- Core functionality: Ask Claude questions from Neovim
- Code suggestion feature (`ClaudeSuggest`)
- Code review feature (`ClaudeReview`)
- Code generation feature (`ClaudeGenerate`)
- Code explanation feature (visual mode `<Space>ce`)
- Default keybindings (`<Space>ca`, `<Space>cs`, `<Space>cr`, `<Space>cg`, `<Space>ce`)
- LazyVim integration
- Uses `claude --print` command
- No API key required - uses existing Claude CLI auth
- Comprehensive documentation (README, MANUAL, INSTALL)
- Installation, update, and uninstall scripts
- Example workflows
- Test file for trying out features

### Technical Details
- Built with Lua for Neovim
- Uses `vim.fn.jobstart` for async execution
- Responses displayed in vertical splits
- Markdown syntax highlighting for responses
- Configurable keymaps

## Future Plans

### Planned Features for v2.1
- [ ] Streaming responses for faster feedback
- [ ] Context from multiple files
- [ ] Project-wide refactoring suggestions
- [ ] LSP integration
- [ ] Custom system prompts per provider
- [ ] Response history browser
- [ ] Chat-style conversations
- [ ] Telescope integration for history
- [ ] Auto-apply code changes option
- [ ] Support for more AI providers

### Improvements
- [ ] Better error handling across providers
- [ ] Rate limiting awareness
- [ ] Progress indicators for long operations
- [ ] Configurable response window position
- [ ] Enhanced syntax highlighting in diffs
- [ ] Session persistence
- [ ] Custom keymaps per language
- [ ] Integration with `bd` (Beads) for task tracking
- [ ] Performance optimizations

## Version History

- **2.0.0** (2025-12-27) - Multi-AI provider support, inline suggestions, diff views
- **1.0.0** (2025-12-27) - Initial release with Claude integration
