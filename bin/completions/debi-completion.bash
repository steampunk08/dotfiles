_debi_complete()
{
   local cword=${COMP_WORDS[$COMP_CWORD]}
   local debs=$(ls $DEBS_DIRECTORY | grep ^$cword | sed s/_.*//g)
   COMPREPLY=($(compgen -W "$debs" "$cword"))
}

complete -F _debi_complete debi
