# Siphesihle Mhlongo's

# $HOME/zsource/plugins
# $HOME/zsource/configs/prompt.zsh

# startup {{{
if [[ -z $(pgrep crond) ]]; then
   crond -c $HOME/crontabs
fi

# always have a session running
tmux has-session 2> /dev/null
if [ $? -ne 0 ]; then
   tmux new-session -s default -n editor
fi
# }}}
# autoloading {{{
autoload -U promptinit
promptinit

autoload -U compinit
compinit
zstyle :compinstall filename $HOME/.zshrc.all
# }}}
# source zsh plugins {{{
ZSH_PLUGIN_DIR=$HOME/.zsh/plugins
source $HOME/.zsh/prompt.zsh

for plugin in $ZSH_PLUGIN_DIR/*; do
   if [ -d $plugin ]; then
      source ${plugin}/*.plugin.zsh
   fi
done
# }}}
# shell options {{{
setopt INTERACTIVE_COMMENTS
setopt PROMPT_SUBST
setopt CORRECT
setopt AUTO_CD
setopt NULL_GLOB EXTENDED_GLOB NOMATCH
# }}}
# exports {{{
# misc exports {{{
export ZSH_FUNCTIONS=$PREFIX/share/zsh/$ZSH_VERSION/functions
export PATH=$HOME/bin:$HOME/qmk/bin:$PATH
export HISTFILE=~/.zsh-history
export ZSH_COMPDUMP=~/.zcompdump
export KEYTIMEOUT=1
export HISTSIZE=1000
export SAVEHIST=1000
export SHELL=$PREFIX/bin/zsh
export EDITOR=nvim
export PAGER=less
export TERM=xterm-256color
export TODO_PATH=~/.todo
export CRONTABS_DIR=~/crontabs
# export XDG_CONFIG_HOME=$HOME
# }}}
# less options {{{
export LESS="Ri"
export LESS_TERMCAP_mb=$'\e[38;5;154m'
export LESS_TERMCAP_md=$'\e[38;5;105m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;38;5;154m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;48;5;111m'
export LESS_TERMCAP_se=$'\e[0m'
# }}}
# zsh highlight {{{
declare -A ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export ZSH_HIGHLIGHT_STYLES[default]=fg=197
export ZSH_HIGHLIGHT_STYLES[normal]=none
export ZSH_HIGHLIGHT_STYLES[comment]=fg=246
export ZSH_HIGHLIGHT_STYLES[globbing]=fg=197,bold
export ZSH_HIGHLIGHT_STYLES[path]=fg=197,bold
export ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=111
export ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=105
export ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=105
export ZSH_HIGHLIGHT_STYLES[precommand]=fg=111
export ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=197
export ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=67
export ZSH_HIGHLIGHT_STYLES[arg0]=fg=111
export ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=241
export ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=241
export ZSH_HIGHLIGHT_STYLES[bracket-error]=none
export ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=white
export ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=242
export ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=white
export ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=242
#export ZSH_HIGHLIGHT_REGEXP+=('\b\$.*\b' fg=67)
# }}}
# }}}
# aliases {{{
alias ebrc="vim ~/.bashrc"
alias evrc="vim ~/.vimrc"
alias etrc="vim ~/.tmux.conf"
alias ezrc="vim ~/.zshrc"
alias szrc="source ~/.zshrc"
alias sbrc="bash ~/.bashrc"
alias mo="tmux move-window -t"
alias re="tmux rename-window"

alias ls="refresh-ls-colours && \\ls -a"
alias lf="ls -lhS"
alias la="ls -sh"
alias mkdir="mkdir -pv"
alias rm="trash add"
alias rrm="\rm -r "
alias cp="cp -r"
alias python="python2"
alias server="python2 -m SimpleHTTPServer"
alias crontab="crontab -c $HOME/crontabs/"
alias pa="play-audio"
# }}}
# zstyles {{{
# generate $LS_COLORS
eval $(dircolors -b ~/.termux/.dircolors)

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
zstyle ':completion:*' path-completion true

if [ -f $HOME/.w3m/history ]; then
   zstyle ':completion:*' urls $HOME/.w3m/history
fi
#zstyle ':completion:*' select-scroll 
# }}}
# widgets {{{
autoload -Uz edit-command-line

function zle-keymap-select() {
   zle reset-prompt
   zle -R
}

TRAPWINCH() {
   zle &&  zle -R
}

zle -N zle-keymap-select
zle -N edit-command-line

bindkey -v
bindkey -M vicmd 'v' edit-command-line

bindkey "^?" backward-delete-char
bindkey "^h" backward-delete-char
bindkey "^w" vi-backward-kill-word

bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^r" history-incremental-search-backward
bindkey "^n" history-search-forward
bindkey "^p" history-search-backward
bindkey "^l" forward-char
bindkey "^f" forward-char
bindkey "^b" backward-char

bindkey "^[f" forward-word
bindkey "^[b" forward-word
# }}}
# utility functions {{{
# refresh-ls-colours {{{
refresh-ls-colours() {
   eval $(dircolors -b ~/.termux/.dircolors)
}
# }}}
# empty {{{
empty() { \rm -r ~/.trash/*; }
# }}} 
# addman {{{
addman() {
   if [[ $1 =~ '\.gz' ]]; then
      gunzip -k $1
   fi
   MAN_DIR=$PREFIX/share/man
   if [[ -z $2 ]]; then
      mv ${1/.gz/} $MAN_DIR/man1
   else
      mv ${1/.gz/} $MAN_DIR/man${2}
   fi
   makewhatis $MAN_DIR
}
# }}}
# centralize {{{
# FIXME
centralize() {
   screen_width=$(stty size | sed s/.\*\ //)

   max_length=0
   for test in ${(ps:\n:)1}; do
      if [[ max_length < ${#test} ]]; then
         max_length=${#test}
      fi
      #echo ${#test}
      #echo $max_length
   done
   for line in ${(ps:\n:)1}; do
      print ${(l:($screen_width+${max_length})/2:: :)line}
   done
}
# }}}
# }}}

# vim: fdm=marker fdl=0
