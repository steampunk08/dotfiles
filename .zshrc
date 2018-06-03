# Siphesihle Mhlongo's Zsh Configuration

export PATH=/storage/sdcard1/Android/data/com.termux:$HOME/bin:$PATH
export LD_LIBRARY_PATH=/storage/sdcard1/Android/data/com.termux:$LD_LIBRARY_PATH
hash -d ext=/storage/sdcard1/Android/data/com.termux
hash -d debs=/storage/sdcard1/.termux-debs

# tmux lock: always have a session running

# NOTE: anything can reside in this section
# {{{ premeable
autoload -U promptinit
promptinit

autoload -U compinit
compinit
zstyle :compinstall filename '/data/data/com.termux/files/home/.zshrc'

ZSH_FUNCTIONS=/data/data/com.termux/files/usr/share/zsh/5.4.2/functions

plugins=( vi-mode )

export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

source $HOME/.zprompt

# source zsh plugins
for i in $HOME/zsh/*; do
   if [ -d $i ]; then
      source ${i}/*.plugin.zsh
   fi
done
# }}}

# NOTE: section is for zle keybindings
# {{{ bindings 
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
# }}}

# NOTE: section is for zsh options
# {{{ zsh options
setopt INTERACTIVE_COMMENTS # allow inline comments like this
#setopt PROMPT_SUBST
setopt CORRECT
setopt AUTO_CD EXTENDED_GLOB NOMATCH
# }}}

# NOTE: section is for exports
# {{{ exports
export HISTFILE=~/.zsh-history
export ZSH_COMPDUMP=~/.zcompdump
export KEYTIMEOUT=1
export HISTSIZE=1000
export SAVEHIST=1000
export SHELL=$PREFIX/bin/zsh
export EDITOR=vim
export TERM=xterm-256color

export LESS_TERMCAP_mb=$'\e[38;5;154m'
export LESS_TERMCAP_md=$'\e[38;5;105m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;38;5;154m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;48;5;111m'
export LESS_TERMCAP_se=$'\e[0m'

declare -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[default]=fg=197
ZSH_HIGHLIGHT_STYLES[normal]=none
ZSH_HIGHLIGHT_STYLES[comment]=fg=246
ZSH_HIGHLIGHT_STYLES[globbing]=fg=197,bold
ZSH_HIGHLIGHT_STYLES[path]=fg=105
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=111
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=105
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=105
ZSH_HIGHLIGHT_STYLES[precommand]=fg=111
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=197
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=67
ZSH_HIGHLIGHT_STYLES[arg0]=fg=154,bold
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=241
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=241
ZSH_HIGHLIGHT_STYLES[bracket-error]=none
ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=white
ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=242
ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=white
ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=242
# }}}

# NOTE: section is for aliases and alias functions
# {{{ aliases
alias ebrc="vim ~/.bashrc"
alias evrc="vim ~/.vimrc"
alias etrc="vim ~/.tmux.conf"
alias ezrc="vim ~/.zshrc"
alias szrc="source ~/.zshrc"
alias sbrc="bash ~/.bashrc"

function mvtrash() {
   [ -d ~/.trash/ ] || mkdir $HOME/.trash/
   mv -f $@ ~/.trash/
}

if [ ! $ZSH_MINIMAL_MODE ]; then
   # termux spercific aliases
   alias play-audio="play-audio-with-banner"
   alias suicide="pkill -x com.termux"
fi

_refresh_ls_colours() {
   eval $(dircolors -b ~/.termux/.dircolors)
}

alias ls="_refresh_ls_colours && \\ls -a"
alias lf="ls -lhS"
alias la="ls -sh"
alias mkdir="mkdir -pv"
alias rm="mvtrash"
alias cp="cp -r"
alias vifm="vifm ."
alias python="python2"
alias server="python2 -m SimpleHTTPServer"

empty() { \rm -r ~/.trash/*; }
# }}}


tmux has-session 2> /dev/null
if [ $? -ne 0 ]; then
   tmux new-session -s default -n editor
   #tmux new-window -n navigator

   #echo $(which addon)
   #addon nav
   #addon music

   #tmux select-window -t .1
fi

stty sane
# vim: fdm=marker:fmr={{{,}}}:fdl=0:
