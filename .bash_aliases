# enable color support of ls and also add handy aliases

alias ls="ls -a --color=auto"
alias la="ls -hs"
alias ll='ls -l'

function lp() {
    ls --color=yes -l $@ | awk '{ print $1, $9, $10, $11 }'
}

alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias echo="echo -e"
alias apt="apt -y"

alias cp="cp -rv"
alias dd="dd status=progress"
alias rm="rm -v"
alias mkdir="mkdir -pv"

alias ebrc="$EDITOR ~/.bashrc"
alias sbrc=". ~/.bashrc"