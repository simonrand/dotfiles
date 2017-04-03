# PATH
PATH=$(brew --prefix coreutils)/libexec/gnubin:./bin:$PATH

# Homebrew
export PATH="./bin:/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# Prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[0;37m\]$(pwd)$(__git_ps1) $ \[\033[0;30m\]'
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'

# Git Completions
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# rbenv
eval "$(rbenv init -)"

# Aliases

# Shell
mcd () { mkdir -p "$1" && cd "$1"; }

# Git
alias gcom='git commit -m'
alias gco='git checkout'
alias gs='git status'
alias gl='git log'
alias ga='git add'
# alias clean_branches='git branch | grep -v "staging" | xargs git branch -D'

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
alias fs='foreman start'

# Local specific
if [ -f ~/.bash_local ]; then
  source ~/.bash_local
fi
