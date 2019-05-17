_dx_complete()
{
   cword=${COMP_WORDS[$COMP_CWORD]}

   if [ $COMP_CWORD -eq 1 ]; then
      COMPREPLY=($(compgen -W "--dex" "'$cword'"))
   elif [ $COMP_CWORD -eq 2 ]; then
      COMPREPLY=($(compgen -W "--output" "'$cword'"))
   elif [ $COMP_CWORD -eq 3 ]; then
      possible_names="classes.dex "
      possible_names+="$(ls | grep \\.class | sed s/\\.class/.dex/g)"

      COMPREPLY=($(compgen -W "$possible_names" "'$cword'"))
   else
      classes=$(ls | grep \\.class | sed s/\\$/\\\\$/g)
      COMPREPLY=($(compgen -W "$classes" "'$cword'"))
   fi
}
complete -F _dx_complete dx
