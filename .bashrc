# Siphesihle Mhlongo's Bash Config

# exports {{{
export SHELL=$PREFIX/bin/bash
export PERSONAL_PATH=$HOME/bin
export PATH=$HOME/bin:$PATH:$PERSONAL_PATH
export TERM=xterm-256color
export EDITOR=nvim
export PAGER=less
export EXTCARD=/storage/3039-3361
export TERMUX=$EXTCARD/Android/data/com.termux/
export HISTCONTROL=erasedups:ignoredups
export CRONTABS_DIR=$HOME/crontabs
export DEBS_DIRECTORY=$TERMUX/.debs
export COMP_DIRECTORY=$HOME/bin/completions

[[ -z $USERNAME ]] && USERNAME="Sphe M"

export XDG_CONFIG_HOME=$HOME/.config

export LESS="Ri"
export LESS_TERMCAP_mb=$'\e[38;5;154m'
export LESS_TERMCAP_md=$'\e[38;5;105m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;38;5;154m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;48;5;111m'
export LESS_TERMCAP_se=$'\e[0m'

export ADDONS_FOLDER=~/addons
# }}}
# shell options {{{
set -o vi

shopt -s autocd
shopt -s direxpand
shopt -s globasciiranges globstar dotglob
shopt -s interactive_comments
shopt -s lithist
# }}}
# startup {{{
if [[ -z $(pgrep crond) ]]; then
   crond -c $CRONTABS_DIR
fi

# always have a session running
tmux has-session 2>/dev/null
if [ $? -ne 0 ]; then
   tmux new-session -s def -n editor 2>/dev/null
fi

for f in $COMP_DIRECTORY/*-completion.bash; do
   source $f
done
# }}}
# aliases {{{
# tmux spercific {{{
alias new="tmux new-window"
alias mo="tmux move-window -t"
alias re="tmux rename-window"
# }}}
# edit/source configs {{{
alias ebrc="$EDITOR ~/.bashrc"
alias evrc="$EDITOR ~/.vimrc"
alias etrc="$EDITOR ~/.tmux.conf"
alias eirc="$EDITOR ~/.inputrc"
alias sbrc="source ~/.bashrc"
# }}}
# misc aliases {{{
alias rm="trash add"
alias dx="dx $@ 1>/dev/null"
alias rrm="\rm -r"
alias mkdir="mkdir -pv"
alias play="scriptreplay -t replay.timing typescript"
alias pa="play-audio"
alias crontab="crontab -c $CRONTABS_DIR"
# }}}
# }}}
# prompt customization {{{
# Colors
BLURPLE="\e[38;5;105m"
GRAY="\e[38;5;244m"
YELLOW="\e[38;5;220m"
LIGHT_BLUE="\e[38;5;111m"
COFFEE="\e[38;5;95m"
CLEAR="\e[0m"

_todo_list() {
   todo -l | while read line; do echo "   $line"; done
}

_tr() {
   echo -en $LIGHT_BLUE
   if [[ $1 == "home" ]]; then
      echo -n '$HOME'
   else
      echo -n $1
   fi
}
_curdir_seg1() {
   before_base=$(basename "$(realpath ..)")
   _tr $before_base
}
   
_curdir_seg2() {
   path_base=$(basename "$(pwd)")
   _tr $path_base
}

_pwd() {
   _curdir_seg1
   echo -en "\e[0m/"
   _curdir_seg2
}

_ps1_gen() {
   SECTION_1="${BLURPLE}$USERNAME$CLEAR [ $YELLOW\$(lsbytesum)$CLEAR ]"
   SECTION_1="$SECTION_1( $LIGHT_BLUE\$(_curdir_seg2)$CLEAR )"
   SECTION_2="$GRAY\$(_todo_list)$CLEAR"
   SECTION_3="-\$ "

   echo "\n$SECTION_1\n$SECTION_2\n$SECTION_3"
}
export PS1=$(_ps1_gen)
# }}}
# utilities functions {{{
# ls modifications {{{
DIRCOLORS_PATH=~/.dircolors

_refresh_ls_colours() {
   eval $(dircolors -b $DIRCOLORS_PATH 2>/dev/null)
}
_refresh_ls_colours

alias ls="_refresh_ls_colours && ls -a"
alias lf="ls -lhS"
alias la="ls -hs"
# }}}
# addman function {{{
addman() {
   if [[ $1 =~ \.gz$ ]]; then
      gunzip -k $1
   fi
   MAN_DIR=$PREFIX/share/man
   if [[ -z $2 ]]; then
      name=$(basename $1 .gz)
      mv $name $MAN_DIR/man1
   else
      mv $name $MAN_DIR/man${2}
   fi
   makewhatis $MAN_DIR
}
# }}}
# fsize function {{{
fsize() { ls -l $@ | awk '{ print $5 }'; }
# }}}
# }}}

trash enable

# vim: fdm=marker fdl=0
