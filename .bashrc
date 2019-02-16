# Siphesihle Mhlongo's Bash Config

export SHELL=$PREFIX/bin/bash
export PATH=$HOME/bin:$PATH
export TERM=xterm-256color
export EDITOR=nvim
export EXTCARD=/storage/3039-3361

[[ -z $USERNAME ]] && USERNAME="Sphe M"

export XDG_CONFIG_HOME=$HOME/.config

export LESS_TERMCAP_mb=$'\e[38;5;154m'
export LESS_TERMCAP_md=$'\e[38;5;105m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;38;5;154m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;48;5;111m'
export LESS_TERMCAP_se=$'\e[0m'

alias new="termux new-window"
alias rm="trash add"
alias play="scriptreplay -t replay.timing typescript"

alias ebrc="$EDITOR ~/.bashrc"
alias evrc="$EDITOR ~/.vimrc"
alias etrc="$EDITOR ~/.tmux.conf"
alias sbrc="source ~/.bashrc"

_todo_list() {
   todo -l | while read line; do echo "   $line"; done
}

_pwd() {
   path_base=$(basename $(pwd))
   if [[ $path_base == "home" ]]; then
      echo '$HOME'
   else
      echo $path_base
   fi
}

_ps1_gen() {
      BLURPLE="\e[38;5;105m"
         GRAY="\e[38;5;244m"
       YELLOW="\e[38;5;220m"
   LIGHT_BLUE="\e[38;5;111m"
        CLEAR="\e[0m"

   SECTION_1="${BLURPLE}$USERNAME$CLEAR [ $YELLOW\$(lsbytesum)$CLEAR ]"
   SECTION_1="$SECTION_1( $LIGHT_BLUE\$(_pwd)$CLEAR )"
   SECTION_2="$GRAY\$(_todo_list)$CLEAR"
   SECTION_3="-\$ "

   echo "\n$SECTION_1\n$SECTION_2\n$SECTION_3"
}
export PS1=$(_ps1_gen)

DIRCOLORS_PATH=~/.termux/.dircolors

_refresh_ls_colours() {
   eval $(dircolors -b $DIRCOLORS_PATH 2>/dev/null)
}
alias ls="_refresh_ls_colours && ls -a"
alias lf="ls -lhS"
alias la="ls -hs"

vimscript() {
   tmux has-session vimscript

   if [ $? != 0 ]; then
      tmux new-session -s vimscript -n editor -d
      tmux new-window -n console
      tmux new-window -n music

   fi
}
