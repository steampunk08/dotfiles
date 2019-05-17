_addon_complete()
{
   local addons=$(ls $ADDONS_FOLDER | sed s/\.addon//)
   local cword=${COMP_WORDS[$COMP_CWORD]}
   local IFS=$'\n'
   
   if [ $COMP_CWORD -eq 1 ]; then
      COMPREPLY=($(compgen -W "$addons" -- ${COMP_WORDS[1]}))
   elif [[ ${COMP_WORDS[1]} = "-e" ]] && [ $COMP_CWORD -eq 2 ]; then
      COMPREPLY=($(compgen -W "$addons" -- $cword))
   elif [[ ${COMP_WORDS[1]} = "-d" ]]; then
      COMPREPLY=($(compgen -W "$addons" -- $cword))
   fi
}

complete -F _addon_complete -o default addon
