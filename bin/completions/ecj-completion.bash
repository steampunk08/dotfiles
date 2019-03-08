_ecj_complete()
{
   sources=$(ls | grep \\.java)
   COMPREPLY=($(compgen -W "$sources" "${COMP_WORDS[$COMP_CWORD]}"))
}

complete -F _ecj_complete ecj
