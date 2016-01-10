# PATH
PATH=$(brew --prefix coreutils)/libexec/gnubin:./bin:$PATH

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

# Git
alias gcom='git commit -m'

# Elixir
alias ips='iex -S mix phoenix.server'
