_dalvikvm_completion()
{
   cword=${COMP_WORDS[$COMP_CWORD]}

   if [ $COMP_CWORD -eq 1 ]; then
      COMPREPLY=($(compgen -W "-classpath" "$cword"))
   elif [ $COMP_CWORD -eq 2 ]; then
      dex_files=$(ls | grep \\.dex)
      COMPREPLY=($(compgen -W "$dex_files" "$cword"))
   else
      possible_names=$(ls | grep \\.class | sed s/\\.class//g)
      COMPREPLY=($(compgen -W "$possible_names" "$cword"))
   fi
}

complete -F _dalvikvm_completion dalvikvm
