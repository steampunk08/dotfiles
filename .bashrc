# Siphesihle Mhlongo's Bash Config

alias ebrc="vim ~/.bashrc"
alias evrc="vim ~/.vimrc"
alias etrc="vim ~/.tmux.conf"
alias pdf="qpdf"

export EDITOR=vim
export SHELL=$PREFIX/bin/bash
export TERM=xterm-256color
export PATH=~/bin:$PATH

export LESS_TERMCAP_mb=$'\e[38;5;154m'
export LESS_TERMCAP_md=$'\e[38;5;105m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;38;5;154m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;48;5;111m'
export LESS_TERMCAP_se=$'\e[0m'

_ps1_gen() {
   YELLOW="\e[38;5;111m"
   BLUE="\e[38;5;105m"
   CLEAR="\e[0m"

   echo "\n${BLUE}Sphe M${CLEAR} [ $YELLOW\W$CLEAR ]\n -\$ "
}
export PS1=$(_ps1_gen)

DIRCOLORS_PATH=~/.termux/.dircolors
_refresh_ls_colours() {
   eval $(dircolors -b $DIRCOLORS_PATH)
}
alias ls="_refresh_ls_colours && ls -a"
alias lf="ls -lhS"

vimscript() {
   tmux has-session vimscript

   if [ $? != 0 ]; then
      tmux new-session -s vimscript -n editor -d
      tmux new-window -n console
      tmux new-window -n music

   fi
}

test_colours() {
   for x in {0..8}; do
      for i in {30..37}; do
         for a in {40..47}; do
            echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
         done
         echo
      done
   done
   echo ""
}
#zsh --login
