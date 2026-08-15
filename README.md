# dotfiles

## Installation

```bash
./setup.sh
```

This links the managed configuration directories and files, including:

- AeroSpace at `~/.config/aerospace/aerospace.toml`
- Ghostty at `~/.config/ghostty/config.ghostty`

## AeroSpace

The AeroSpace config uses a tiled layout with Vim-style navigation:

- `alt-h/j/k/l`: focus a window
- `alt-shift-h/j/k/l`: move a window
- `alt-1` through `alt-9`: switch workspaces
- `alt-shift-1` through `alt-shift-9`: move a window to a workspace
- `alt-colon`, then `h/j/k/l`: group windows in a nested container
- `alt-colon`, then `b`: balance window sizes
- `alt-colon`, then `f`: toggle floating/tiling
