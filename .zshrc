# opam configuration
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# php7.4
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"

# sbt
export PATH="$HOME/sbt/bin:$PATH"

# Haskell
export PATH="$HOME/.local/bin:$PATH"

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
. ~/z/z.sh

# peco settings
# Select previously executed commands. Bound to ctrl-r
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


### Select from previously visited directories. Bound to ctrl-u
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


# Easy branch switching. Can be executed with git checkout lb
alias -g lb='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'


# Enter docker container. Can be executed with de
alias de='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'

# peco for kubernetes
alias -g lc='`kubectx | peco --prompt "CONTEXT>"`'

# fzf for git fixup
function git-fixup() {
  FILTER=${FILTER:-fzf}
  MAX_LOG_COUNT=${MAX_LOG_COUNT:-30}

  if git diff --cached --quiet; then
      commits="No staged changes. Use git add -p to add them."
      ret=1
  else
      commits=$(git log --oneline -n "$MAX_LOG_COUNT")
      ret=$?
  fi

  if [[ "$ret" != 0 ]]; then
      headline=$(head -n1 <<< "$commits")
      if [[ "$headline" = "No staged changes. Use git add -p to add them." ]]; then
          echo "$headline" >&2
      fi
  else
    line=$("$FILTER" <<< "$commits")
    [[ "$?" = 0 && "$line" != "" ]] || exit "$?"

    git commit --fixup "$(awk '{print $1}' <<< "$line")" "$@"
  fi
}

function git-rebase-autosquash() {
  FILTER=${FILTER:-fzf}
  MAX_LOG_COUNT=${MAX_LOG_COUNT:-30}

  commits=$(git log --oneline -n "$MAX_LOG_COUNT")
  line=$("$FILTER" <<< "$commits")
  [[ "$?" = 0 && "$line" != "" ]] || exit "$?"

  git rebase -i --autosquash "$(awk '{print $1}' <<< "$line")" "$@"
}


# LSP server for neovim
PATH=$HOME/lsp:$PATH

# direnv
export EDITOR=vim
eval "$(direnv hook zsh)"

# shortcut
alias gb="git branch"
alias gc="git checkout"
alias gf="git-fixup"
alias gr="git-rebase-autosquash"

# gpg
export GPG_TTY=$(tty)

