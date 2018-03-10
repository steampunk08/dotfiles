#g Siphesihle Mhlongo's Zsh Config
autoload -U compinit
autoload -U promptinit
compinit
promptinit

export ZSH=$HOME/.oh-my-zsh

plugins=(
   vi-mode
   colorize
   git
   zsh-autosuggestions
)
#zsh-navigation-tools

source $ZSH/oh-my-zsh.sh
source $HOME/.zprompt

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey "^Q" push-line-or-edit
bindkey "^F" vi-forward-char
bindkey "^B" vi-backward-char
#bindkey 

#bindkey "^[r" source ~/.zshrc

HISTFILE=~/.zsh-history

setopt INTERACTIVE_COMMENTS # allow inline comments like this
setopt PROMPT_SUBST

todo() {
   echo $@ > ~/.todo
   source ~/.zprompt
}

export SHELL="$PREFIX/bin/zsh"
export PATH=~/bin:$PATH
export EDITOR="vim"
export TERM="xterm-256color"

export LESS_TERMCAP_mb=$'\e[38;5;154m'
export LESS_TERMCAP_md=$'\e[38;5;105m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;38;5;154m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;48;5;111m'
export LESS_TERMCAP_se=$'\e[0m'

alias ebrc="vim ~/.bashrc"
alias evrc="vim ~/.vimrc"
alias etrc="vim ~/.tmux.conf"
alias ezrc="vim ~/.zshrc"

alias szrc="source ~/.zshrc"
alias sbrc="bash ~/.bashrc"

function mvtrash() {
   [ -d ~/.trash/ ] || mkdir ~/.trash/
   mv -f $@ ~/.trash/
}

if [ ! $ZSH_MINIMAL_MODE ]; then
   # Termux Spercific Aliases
   alias play-audio="play-audio-with-banner"
   alias suicide="pkill -x com.termux"
fi

_refresh_ls_colours() {
   eval $(dircolors -b ~/.termux/.dircolors)
}

alias ls="_refresh_ls_colours && ls -ash"
alias lf="ls -lhS"
alias rm="mvtrash"
alias mkdir="mkdir -p"
alias vifm="vifm ."
alias python="python2"
alias server="python2 -m SimpleHTTPServer"
