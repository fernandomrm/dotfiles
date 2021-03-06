#!/bin/bash

if hash brew 2> /dev/null; then
    BREW_PREFIX="$(brew --prefix)"
else
    BREW_PREFIX=""
fi

if [[ -d "${BREW_PREFIX}/opt/coreutils/libexec/" ]]; then
    export PATH="${BREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="${BREW_PREFIX}/opt/coreutils/libexec/gnuman:$MANPATH"
fi

alias df='df -h'
alias du='du -sh'
alias free='free -m'
alias grep='grep --color=auto'
alias la='ls --color=auto -lha'
alias ll='ls --color=auto -lh'
alias ls='ls --color=auto'
alias scpi='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias sshi='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias xclip='xclip -sel clip'

for bc in "/etc/bash_completion" "${BREW_PREFIX}/etc/bash_completion"; do
    if [[ -f "$bc" ]]; then
        # shellcheck source=/dev/null
        . "$bc"
        break
    fi
done

eval "$(dircolors)"

if hash vim 2> /dev/null; then
    EDITOR=$(command -v vim)
    export EDITOR
fi

if [[ -f /etc/redhat-release ]]; then
    PS1_SEP=" "
else
    PS1_SEP=":"
fi

# Prompt colors
BLUE='\[\e[94;1m\]'
CLEAR='\[\e[0m\]'
CYAN='\[\e[96;1m\]'
RED='\[\e[91;1m\]'
WHITE='\[\e[97;1m\]'

export PS1="[${RED}\\u${CYAN}@${BLUE}\\h${CLEAR}${PS1_SEP}${WHITE}\\w${CLEAR}]\\$ "

# Short prompt for presentations:
function short_prompt {
    export PS1="${WHITE}\\$ $CLEAR"
}

if [[ -f "$HOME/.no_history" ]]; then
    unset HISTFILE
else
    export HISTCONTROL="ignoreboth:erasedups"
    export HISTSIZE=10000
fi

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

if [[ -d "$HOME/go" ]]; then
    export GOPATH="$HOME/go"
    export GOBIN="$GOPATH/bin"
    export PATH="$GOBIN:$PATH"
fi

if [[ -d "$HOME/.nodenv" ]]; then
    eval "$(nodenv init -)"
fi

if [[ -d "$HOME/.pyenv" ]]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

if [[ -d "$HOME/.rbenv" ]]; then
    eval "$(rbenv init -)"
fi

# Fix SSH_AUTH_SOCK for screen sessions
if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -fs "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
fi
export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"

case "$TERM" in
    screen*)
        export TERM="screen-256color"
    ;;
    xterm*)
        export TERM="xterm-256color"
    ;;
esac

# Vi mode for interactive terminal:
if [[ $- == *i* ]]; then
    bind -m vi-insert '\C-l':clear-screen
    set -o vi
fi

# fzf should be configured after vi mode:
if [[ -f "$HOME/.fzf.bash" ]]; then
    # shellcheck source=/dev/null
    source "$HOME/.fzf.bash"
    if hash ag 2> /dev/null; then
        export FZF_DEFAULT_COMMAND='ag -g ""'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
    export FZF_DEFAULT_OPTS="--height 100%"
    export FZF_CTRL_T_OPTS="--preview 'head -100 {}'"
fi

if [[ -d "$HOME/.asdf" ]]; then
    . $HOME/.asdf/asdf.sh
    . $HOME/.asdf/completions/asdf.bash
fi
