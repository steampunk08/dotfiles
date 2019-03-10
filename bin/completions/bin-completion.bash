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
      files=$(ls -A $PERSONAL_BIN)

      if [[ $cword =~ completions ]]; then
         files=$(echo $files | sed /completions/d)
         other=($(ls -A $PERSONAL_BIN/completions/))
         for i in ${other[@]}; do
            files+=" completions/$i"
         done
      fi
      COMPREPLY=($(compgen -W "$files" "$cword"))
   fi
}

complete -F _binmgr_complete -o nospace bin
