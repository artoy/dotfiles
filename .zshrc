# opam configuration
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# clang to gcc
# export PATH="/opt/homebrew/bin:$PATH"

# php7.4
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"

# sbt
export PATH="$HOME/sbt/bin:$PATH"

# Haskell
export PATH="$HOME/.local/bin:$PATH"

# LLVM
# export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
# [ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# Go
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"

# kubernetes
alias k=kubectl
autoload -Uz compinit
compinit
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# starship
eval "$(starship init zsh)"

# binutils
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# delete useless files created by tex
alias rmtex='sh ~/shell_script/rm_tex.sh'

# python3
# alias python="/opt/homebrew/bin/python3"
# alias pip="/opt/homebrew/bin/pip3"
# alias python3="/opt/homebrew/bin/python3"
# alias pip3="/opt/homebrew/bin/pip3"

# pg_config
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# ruby
export PATH="$HOME/rbenv:$PATH"
# eval "$(rbenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

# istio
export PATH=$HOME/istio-1.15.1/bin:$PATH

# horsat2
export PATH=$HOME/git/horsat2:$PATH

# z command
# . ~/z/z.sh

# peco settings
# 過去に実行したコマンドを選択。ctrl-rにバインド
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# search a destination from cdr list
function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  peco --query "$LBUFFER"
}


### 過去に移動したことのあるディレクトリを選択。ctrl-uにバインド
function peco-cdr() {
  local destination="$(peco-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^u' peco-cdr


# ブランチを簡単切り替え。git checkout lbで実行できる
alias -g lb='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'


# dockerコンテナに入る。deで実行できる
alias de='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'

# peco for kubernetes
alias -g lc='`kubectx | peco --prompt "CONTEXT>"`'

PATH=~/.console-ninja/.bin:$PATH

# neovim用のlspサーバ
PATH=$HOME/lsp:$PATH

# direnv
export EDITOR=vim
eval "$(direnv hook zsh)"

# shortcut
alias gb="git branch"
alias gc="git checkout"

# gpg
export GPG_TTY=$(tty)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

