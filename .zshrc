# opam configuration
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Homebrew uses different default prefixes on macOS and Linux.  Discover an
# existing installation before referring to formula-managed paths so a fresh
# machine can start zsh before Homebrew has been installed.
homebrew_command_path="${commands[brew]-}"
if (( ! $+commands[brew] )); then
  for homebrew_executable in \
    /opt/homebrew/bin/brew \
    /usr/local/bin/brew \
    /home/linuxbrew/.linuxbrew/bin/brew
  do
    if [[ -x "$homebrew_executable" ]]; then
      if homebrew_shellenv="$("$homebrew_executable" shellenv 2>/dev/null)"; then
        eval "$homebrew_shellenv"
        homebrew_command_path="$homebrew_executable"
        break
      fi
    fi
  done
  unset homebrew_executable
else
  if homebrew_shellenv="$(brew shellenv 2>/dev/null)"; then
    eval "$homebrew_shellenv"
  fi
fi
unset homebrew_shellenv

# A NixOS profile can deliberately provide a root-owned brew wrapper in front
# of Homebrew's mutable prefix. Preserve that already-selected entry point
# after `brew shellenv` prepends the prefix's bin directory.
if [[ -n "$homebrew_command_path" && \
      "$homebrew_command_path" != "${HOMEBREW_PREFIX:-}/bin/brew" ]]; then
  export PATH="${homebrew_command_path:h}:$PATH"
  rehash
fi
unset homebrew_command_path

if (( $+commands[brew] )); then
  homebrew_prefix="$(brew --prefix 2>/dev/null)"
  if [[ -n "$homebrew_prefix" ]]; then
    export PATH="$homebrew_prefix/opt/php@7.4/bin:$PATH"
    export PATH="$homebrew_prefix/opt/php@7.4/sbin:$PATH"
    export PATH="$homebrew_prefix/opt/binutils/bin:$PATH"

    if [[ -r "$homebrew_prefix/etc/profile.d/z.sh" ]]; then
      source "$homebrew_prefix/etc/profile.d/z.sh"
    fi
  fi
  unset homebrew_prefix
fi

# sbt
export PATH="$HOME/sbt/bin:$PATH"

# Haskell
export PATH="$HOME/.local/bin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"

# Docker Desktop completions are optional and live under the current user's
# home directory on macOS.
if [[ -d "$HOME/.docker/completions" ]]; then
  fpath=("$HOME/.docker/completions" "${fpath[@]}")
fi

# kubernetes
alias k=kubectl
autoload -Uz compinit
compinit
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# starship
eval "$(starship init zsh)"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# delete useless files created by tex
alias rmtex='sh ~/shell_script/rm_tex.sh'

# pg_config
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# ruby
export PATH="$HOME/rbenv:$PATH"
# eval "$(rbenv init -)"

# istio
export PATH=$HOME/istio-1.15.1/bin:$PATH

# horsat2
export PATH=$HOME/git/horsat2:$PATH

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
alias gs="git switch"

# gpg
export GPG_TTY=$(tty)

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Google Cloud SDK
GCLOUD_SDK_HOME="$HOME/google-cloud-sdk"
if [ -f "$GCLOUD_SDK_HOME/path.zsh.inc" ]; then . "$GCLOUD_SDK_HOME/path.zsh.inc"; fi
if [ -f "$GCLOUD_SDK_HOME/completion.zsh.inc" ]; then . "$GCLOUD_SDK_HOME/completion.zsh.inc"; fi

# dotnet
export PATH="$PATH:$HOME/.dotnet/tools"
