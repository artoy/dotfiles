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
