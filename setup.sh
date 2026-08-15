#!/bin/zsh

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)

# Validate the source before replacing any existing links in the user's home.
zsh -n "$SCRIPT_DIR/.zshrc" || exit 1

typeset -a transaction_sources
typeset -a transaction_destinations
typeset -a transaction_backups

rollback_setup() {
  local exit_status="$?"
  local index src dest backup
  trap - EXIT HUP INT TERM

  for (( index = ${#transaction_destinations}; index >= 1; index-- )); do
    src="${transaction_sources[$index]}"
    dest="${transaction_destinations[$index]}"
    backup="${transaction_backups[$index]}"

    if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
      rm -f "$dest" || true
    elif [[ -e "$dest" || -L "$dest" ]]; then
      echo "warning: leaving unexpected rollback path in place: $dest" >&2
    fi

    if [[ -n "$backup" && ( -e "$backup" || -L "$backup" ) ]]; then
      if [[ ! -e "$dest" && ! -L "$dest" ]]; then
        mv -n "$backup" "$dest" ||
          echo "warning: restore manually: $backup -> $dest" >&2
      else
        echo "warning: restore manually: $backup -> $dest" >&2
      fi
    fi
  done

  exit "$exit_status"
}

link_path() {
  local src="$1"
  local dest="$2"
  local backup="${dest}.pre-dotfiles-backup"
  local saved_backup=""
  local transaction_recorded=0

  if [[ -L "$dest" ]]; then
    if [[ "$(readlink "$dest")" == "$src" ]]; then
      return
    fi
    saved_backup="$backup"
    transaction_sources+=("$src")
    transaction_destinations+=("$dest")
    transaction_backups+=("$saved_backup")
    transaction_recorded=1
    mv -n "$dest" "$backup" || exit 1
  elif [[ -f "$dest" ]]; then
    saved_backup="$backup"
    transaction_sources+=("$src")
    transaction_destinations+=("$dest")
    transaction_backups+=("$saved_backup")
    transaction_recorded=1
    mv -n "$dest" "$backup" || exit 1
  elif [[ -e "$dest" ]]; then
    echo "error: $dest already exists and is not a symlink or regular file" >&2
    echo "move it out of the way before running setup.sh" >&2
    exit 1
  fi

  if (( ! transaction_recorded )); then
    transaction_sources+=("$src")
    transaction_destinations+=("$dest")
    transaction_backups+=("$saved_backup")
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "error: could not preserve $dest as $backup" >&2
    exit 1
  fi
  if [[ -n "$saved_backup" && ! -e "$saved_backup" && ! -L "$saved_backup" ]]; then
    echo "error: backup was not created: $saved_backup" >&2
    exit 1
  fi

  ln -s "$src" "$dest" || exit 1
}

preflight_link() {
  local src="$1"
  local dest="$2"
  local backup="${dest}.pre-dotfiles-backup"

  if [[ ! -e "$src" && ! -L "$src" ]]; then
    echo "error: managed source does not exist: $src" >&2
    exit 1
  fi
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    return
  fi
  if [[ ( -L "$dest" || -f "$dest" ) && ( -e "$backup" || -L "$backup" ) ]]; then
    echo "error: backup path already exists: $backup" >&2
    echo "move it out of the way before running setup.sh" >&2
    exit 1
  fi
  if [[ -e "$dest" && ! -L "$dest" && ! -f "$dest" ]]; then
    echo "error: $dest already exists and is not a symlink or regular file" >&2
    echo "move it out of the way before running setup.sh" >&2
    exit 1
  fi
}

# Check every destination before changing any of them. Existing regular files
# and unrelated symlinks are preserved under a deterministic, non-overwriting
# backup name.
preflight_link "$SCRIPT_DIR/git" "$HOME/.config/git"
preflight_link "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
preflight_link "$SCRIPT_DIR/ghostty" "$HOME/.config/ghostty"
preflight_link "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
preflight_link "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
preflight_link "$SCRIPT_DIR/starship.toml" "$HOME/.config/starship.toml"
preflight_link "$SCRIPT_DIR/.ideavimrc" "$HOME/.ideavimrc"
preflight_link "$SCRIPT_DIR/.latexmkrc" "$HOME/.latexmkrc"

mkdir -p "$HOME/.config"

trap rollback_setup EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

link_path "$SCRIPT_DIR/git" "$HOME/.config/git"
link_path "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
link_path "$SCRIPT_DIR/ghostty" "$HOME/.config/ghostty"
link_path "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
link_path "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
link_path "$SCRIPT_DIR/starship.toml" "$HOME/.config/starship.toml"
link_path "$SCRIPT_DIR/.ideavimrc" "$HOME/.ideavimrc"
link_path "$SCRIPT_DIR/.latexmkrc" "$HOME/.latexmkrc"

trap - EXIT HUP INT TERM
echo "Dotfiles linked. Start a new login shell to load the updated configuration."
