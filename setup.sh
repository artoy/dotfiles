#!/bin/zsh

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)

link_path() {
  local src="$1"
  local dest="$2"

  if [[ -L "$dest" || -f "$dest" ]]; then
    rm -f "$dest" || exit 1
  elif [[ -e "$dest" ]]; then
    echo "error: $dest already exists and is not a symlink or regular file" >&2
    echo "move it out of the way before running setup.sh" >&2
    exit 1
  fi

  ln -s "$src" "$dest" || exit 1
}

mkdir -p "$HOME/.config"

link_path "$SCRIPT_DIR/git" "$HOME/.config/git"
link_path "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
link_path "$SCRIPT_DIR/ghostty" "$HOME/.config/ghostty"
link_path "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
link_path "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
link_path "$SCRIPT_DIR/starship.toml" "$HOME/.config/starship.toml"
link_path "$SCRIPT_DIR/.ideavimrc" "$HOME/.ideavimrc"
link_path "$SCRIPT_DIR/.latexmkrc" "$HOME/.latexmkrc"

source "$HOME/.zshrc"
