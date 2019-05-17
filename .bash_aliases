#!/usr/bin/bash

# enable color support of ls and also add handy aliases

DIRCOLORS_PATH=~/.termux/.dircolors

_refresh_ls_colours() {
   eval $(dircolors -b $DIRCOLORS_PATH 2>/dev/null)
}

alias ls="_refresh_ls_colours && ls -a --color=always"
alias la="ls -hs"
alias ll='ls -l'
alias lf='ls -CF'

if [ -x /usr/bin/dircolors ]; then
    alias dir='dir --color=auto'dircolors
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# misc. aliases
alias cp="cp -r"
alias apti="apt -y install"
alias aptr="apt autoremove"

alias rm="trash add"
alias rrm="\rm -r"
alias mkdir="mkdir -pv"
alias play="scriptreplay -t replay.timing typescript"
alias crontab="crontab -c $CRONTABS_DIR"

# tmux spercific
alias new="tmux new-window"
alias mo="tmux move-window -t"
alias re="tmux rename-window"

# edit/source configs
alias evrc="$EDITOR ~/.vimrc.desktop"
alias etrc="$EDITOR ~/.tmux.conf"

alias sbrc="source ~/.bashrc"