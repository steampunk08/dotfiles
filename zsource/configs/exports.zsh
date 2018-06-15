# ZSH CONFIG - EXPORTS

export HISTFILE=~/.zsh-history
export ZSH_COMPDUMP=~/.zcompdump
export KEYTIMEOUT=1
export HISTSIZE=1000
export SAVEHIST=1000
export SHELL=$PREFIX/bin/zsh
export EDITOR=vim
export PAGER=less
export TERM=xterm-256color
export TODO_PATH=~/.todo

export LESS="Ri"
export LESS_TERMCAP_mb=$'\e[38;5;154m'
export LESS_TERMCAP_md=$'\e[38;5;105m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;38;5;154m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;48;5;111m'
export LESS_TERMCAP_se=$'\e[0m'

declare -A ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export ZSH_HIGHLIGHT_STYLES[default]=fg=197
export ZSH_HIGHLIGHT_STYLES[normal]=none
export ZSH_HIGHLIGHT_STYLES[comment]=fg=246
export ZSH_HIGHLIGHT_STYLES[globbing]=fg=197,bold
export ZSH_HIGHLIGHT_STYLES[path]=fg=105
export ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=111
export ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=105
export ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=105
export ZSH_HIGHLIGHT_STYLES[precommand]=fg=111
export ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=197
export ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=67
export ZSH_HIGHLIGHT_STYLES[arg0]=fg=154,bold
export ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=241
export ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=241
export ZSH_HIGHLIGHT_STYLES[bracket-error]=none
export ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=white
export ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=242
export ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=white
export ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=242
#export ZSH_HIGHLIGHT_REGEXP+=('\b\$.*\b' fg=67)
