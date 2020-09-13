####################################################################### Homebrew

export PATH="/usr/local/sbin:$PATH"

################################################################ zsh Completions

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

########################################################################### asdf

echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.zshrc

########################################################################### Ruby

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

######################################################################### Prompt

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats '(%b)%u%c%m '
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='?'
  fi
}

setopt PROMPT_SUBST
PROMPT='%F{8}%B%~%b%f %F{175}${vcs_info_msg_0_}%f$ '

############################################################## Aliases/Functions

# Shell
mcd () { mkdir -p "$1" && cd "$1"; }
alias cleardns='sudo killall -HUP mDNSResponder'

# Git
alias ga='git add'
alias gc='git checkout'
alias gcom='git commit -m'
alias gl='git log'
alias gp='git pull'
alias gpo='git push origin HEAD'
alias gst='git status'
alias remove_merged_branches='git branch --merged | egrep -v "(^\*|master|staging)" | xargs git branch -d'

# Hub/Git
alias gpr='hub pull-request -o -b'

# Elixir
alias ips='iex -S mix phoenix.server'

# Ruby/Rails
alias c='bundle exec rails c'
alias s='bundle exec rails s'
alias g='bundle exec guard'
alias i='irb'

# Foreman
alias f='foreman start'

########################################################################### Misc

# Local specific
if [ -f ~/.zsh_local ]; then
  source ~/.zsh_local
fi
