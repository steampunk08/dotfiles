_ecj_complete()
{
   cword=${COMP_WORDS[$COMP_CWORD]}
   if [ -d $2 ]; then
      sources=($(ls $2 | grep \\.java))
      temp=
      for i in ${sources[@]}; do
         temp+=" ${2%/}/$i"
      done
      sources=$temp
   else
      sources=$(ls | grep \\.java)
   fi
   COMPREPLY=($(compgen -W "$sources" "${COMP_WORDS[$COMP_CWORD]}"))
}

complete -F _ecj_complete -o default -o plusdirs ecj
