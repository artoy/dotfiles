#!/bin/zsh

SCRIPT_DIR=$(cd $(dirname $0); pwd)

rm ~/.config/git
ln -s $SCRIPT_DIR/git ~/.config/git

rm ~/.config/nvim
ln -s $SCRIPT_DIR/nvim ~/.config/nvim

rm ~/.vimrc
ln -s $SCRIPT_DIR/.vimrc ~/.vimrc

rm ~/.zshrc
ln -s $SCRIPT_DIR/.zshrc ~/.zshrc

rm ~/.config/starship.toml
ln -s $SCRIPT_DIR/starship.toml ~/.config/starship.toml

rm ~/.ideavimrc
ln -s $SCRIPT_DIR/.ideavimrc ~/.ideavimrc

rm ~/.latexmkrc
ln -s $SCRIPT_DIR/.latexmkrc ~/.latexmkrc

source ~/.zshrc
