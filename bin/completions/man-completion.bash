if [[ -z $MAN_DIR ]]; then
   MAN_DIR=$PREFIX/share/man
fi

_man_complete()
{
   man_docs=$(ls $MAN_DIR/*/* | sed s/.*\\'/'//g | sed s/\\..*//g)
   cword=${COMP_WORDS[$COMP_CWORD]}

   COMPREPLY=($(compgen -W "$man_docs" "$cword"))
}

complete -F _man_complete man
