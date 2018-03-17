# Siphesihle Mhlongo's Zsh Config
autoload -U compinit
compinit

autoload -U promptinit
promptinit

ZSH_FUNCTIONS=/data/data/com.termux/files/usr/share/zsh/5.4.2/functions

[ -f $ZSH_FUNCTIONS/prompt_steamline_setup ] || if [ -f ~/.zprompt ]; then
   echo -e "\e[38;5;242;1mNOTE:\e[0;38;5;196m STEAMLINE PROMPT WAS JUST LOADED!\e[0m"
   ln -s ~/.zprompt $ZSH_FUNCTIONS/prompt_steamline_setup
fi
prompt steamline &> /dev/null

export ZSH=$HOME/.oh-my-zsh

plugins=(
   vi-mode
   colorize
   zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zprompt

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward
bindkey "^F" vi-forward-char
bindkey "^B" vi-backward-char
bindkey "^L" forward-char

bindkey "^[f" forward-word
bindkey "^[b" forward-word

HISTFILE=~/.zsh-history

setopt INTERACTIVE_COMMENTS # allow inline comments like this
setopt PROMPT_SUBST

export KEYTIMEOUT=1

export SHELL=$PREFIX/bin/zsh
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
