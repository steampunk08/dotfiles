_addon_complete()
{
   local addons=$(ls $ADDONS_FOLDER | sed s/\.addon//)
   local cword
   local IFS=$'\n'
   
   if [ $COMP_CWORD -eq 1 ]; then
      cword=${COMP_WORDS[1]}
   elif [[ ${COMP_WORDS[1]} = "-e" ]] && [ $COMP_CWORD -eq 2 ]; then
      cword=${COMP_WORDS[2]}
   elif [[ ${COMP_WORDS[1]} = "-d" ]]; then
      cword=${COMP_WORDS[$COMP_CWORD]}
   fi
   if [ -z $cword ]; then
      COMPREPLY=($(compgen -W "$addons" $cword))
   fi
}

complete -F _addon_complete addon
