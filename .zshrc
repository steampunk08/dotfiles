# Siphesihle Mhlongo's
# ZSH CONFIG - LINKER

if [[ -z $(pgrep crond) ]]; then
   crond -c $HOME/crontabs
fi
export PATH=$PATH:$HOME/bin

# tmux lock: always have a session running
tmux has-session 2> /dev/null
if [ $? -ne 0 ]; then
   tmux new-session -s default -n editor
fi

export EXTCARD=/storage/sdcard1
hash -d ext=$EXTCARD/Android/data/com.termux
hash -d debs=~ext/.debs

autoload -U promptinit
promptinit

autoload -U compinit
compinit
zstyle :compinstall filename '/data/data/com.termux/files/home/.zshrc'

ZSH_FUNCTIONS=$PREFIX/share/zsh/$ZSH_VERSION/functions

# source zsh config files
ZSH_CONFIG_DIR=$HOME/zsource/configs

for config_file in $ZSH_CONFIG_DIR/*; do
   source $config_file
done

# source zsh plugins
ZSH_PLUGIN_DIR=$HOME/zsource/plugins

for plugin in $ZSH_PLUGIN_DIR/*; do
   if [ -d $plugin ]; then
      source ${plugin}/*.plugin.zsh
   fi
done

setopt INTERACTIVE_COMMENTS # allow inline comments
setopt PROMPT_SUBST
setopt CORRECT
setopt AUTO_CD
setopt NULL_GLOB EXTENDED_GLOB NOMATCH

alias ebrc="vim ~/.bashrc"
alias evrc="vim ~/.vimrc"
alias etrc="vim ~/.tmux.conf"
alias ezrc="vim ~/.zshrc"
alias szrc="source ~/.zshrc"
alias sbrc="bash ~/.bashrc"

if [ ! $ZSH_MINIMAL_MODE ]; then
   # termux spercific aliases
   alias play-audio="play-audio-with-banner"
   alias suicide="pkill -x com.termux"
fi

refresh-ls-colours() {
   eval $(dircolors -b ~/.termux/.dircolors)
}

alias ls="refresh-ls-colours && \\ls -a"
alias lf="ls -lhS"
alias la="ls -sh"
alias mkdir="mkdir -pv"
alias rm="trash add"
alias cp="cp -r"
alias vifm="vifm ."
alias python="python2"
alias server="python2 -m SimpleHTTPServer"
alias crontab="crontab -c $HOME/crontabs/"

empty() { \rm -r ~/.trash/*; }

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

clear
# prettyfy termux !
# banner was generated with `toilet -f mono12`
#underline=$(echo ${(l:60::▀:)})
#{ 
   #centralize $underline
   #centralize "$(cat <<TERMUX_BANNER_STRING
 #▄▄▄▄▄▄▄▄                                                   
 #▀▀▀██▀▀▀                                                   
    #██      ▄████▄    ██▄████  ████▄██▄  ██    ██  ▀██  ██▀ 
    #██     ██▄▄▄▄██   ██▀      ██ ██ ██  ██    ██    ████   
    #██     ██▀▀▀▀▀▀   ██       ██ ██ ██  ██    ██    ▄██▄   
    #██     ▀██▄▄▄▄█   ██       ██ ██ ██  ██▄▄▄███   ▄█▀▀█▄  
    #▀▀       ▀▀▀▀▀    ▀▀       ▀▀ ▀▀ ▀▀   ▀▀▀▀ ▀▀  ▀▀▀  ▀▀▀ 

#TERMUX_BANNER_STRING
#)"
#centralize $underline
#} | lolcat --seed=3

centralize "$(cat $HOME/.fortune)"

stty sane
