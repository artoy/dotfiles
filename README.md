# dotfiles

## Installation

```bash
zsh ./setup.sh
```

This links the managed configuration directories and files, including:

- Ghostty at `~/.config/ghostty/config.ghostty`

The installer validates every destination before changing any link. Existing
regular files and unrelated symlinks are moved to a sibling
`.pre-dotfiles-backup` path without overwriting it. If a later link fails, the
installer attempts to restore every path changed by that run and prints any
remaining manual recovery move.

## C++ debugging in Neovim

The Neovim configuration includes `nvim-dap` and `nvim-dap-ui`, using the
system `lldb-dap` adapter rather than Mason. On macOS, the adapter is resolved
through Xcode with `xcrun`; on other systems, install `lldb-dap` (or the legacy
`lldb-vscode`) with the system toolchain.

Build the program with debug symbols, open its `.cpp` file, and use:

- `<F5>`: start/continue (the executable path is prompted for)
- `<F10>` / `<F11>` / `<F12>`: step over / into / out
- `<Space>db`: toggle a breakpoint
- `<Space>du`: toggle the DAP UI

The attach configuration is also available from the `<F5>` configuration
picker.
