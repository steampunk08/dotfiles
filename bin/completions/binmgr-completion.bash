if [[ -z $PERSONAL_BIN ]]; then
   PERSONAL_BIN=$HOME/bin
fi

_binmgr_complete()
{
   cword=${COMP_WORDS[$COMP_CWORD]}
   action=${COMP_WORDS[1]}

   if [ $COMP_CWORD -eq 1 ]; then
      actions="list chmod edit remove"
      COMPREPLY=($(compgen -W "$actions" "$cword"))
      return
   fi

   if [[ chmod =~ $action ]]; then
      return
   elif [[ edit =~ $action ]] || [[ remove =~ $action ]] || [[ $action = rm ]]; then
      files=$(find $PERSONAL_BIN/ -type f -maxdepth 1 | sed s/.*\\'/'//g | sed s/\\..*//g)
      COMPREPLY=($(compgen -W "$files" "$cword"))
   fi
}

complete -F _binmgr_complete binmgr
