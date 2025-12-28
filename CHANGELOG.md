# Changelog

All notable changes to the Claude Neovim Plugin will be documented in this file.

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

### Files Included
- `plugin/init.lua` - Main plugin code
- `plugin-config.lua` - LazyVim configuration
- `README.md` - Project overview
- `MANUAL.md` - Complete user guide
- `INSTALL.md` - Installation instructions
- `CHANGELOG.md` - This file
- `install.sh` - Automated installation
- `update.sh` - Update existing installation
- `uninstall.sh` - Remove plugin
- `test.lua` - Test file
- `examples/workflow.md` - Usage examples

## Future Plans

### Planned Features
- [ ] Inline code suggestions (copilot-style)
- [ ] Streaming responses
- [ ] Context from multiple files
- [ ] Project-wide refactoring suggestions
- [ ] Integration with LSP
- [ ] Custom system prompts
- [ ] Response history
- [ ] Chat-style conversations
- [ ] Telescope integration for history
- [ ] Diff view for suggestions
- [ ] Auto-apply code changes
- [ ] Support for other editors (Vim, other Neovim distros)

### Improvements
- [ ] Better error handling
- [ ] Rate limiting awareness
- [ ] Progress indicators
- [ ] Configurable response window position
- [ ] Syntax highlighting for code in responses
- [ ] Copy code snippets easily
- [ ] Session persistence
- [ ] Custom keymaps per language
- [ ] Integration with `bd` (Beads) for task tracking

## Contributing

This is currently a personal project. If you have suggestions or improvements:

1. Create a bead: `bd create "Claude plugin suggestion: [your idea]"`
2. Document your idea
3. Test locally
4. Share your findings

## Version History

- **1.0.0** (2025-12-27) - Initial release
