# ZSH CONFIG - PROMPT

if [[ -z $VI_MODE_PROMPT ]]; then
  VI_MODE_PROMPT="{197}<<<"
fi
if [[ -z $EMACS_MODE_PROMPT ]]; then
   EMACS_MODE_PROMPT="{105}@@@"
fi

prompt_vi_mode() {
   vicmd=${KEYMAP/vicmd/$VI_MODE_PROMPT}
   print -n %F
   if [[ $vicmd = 'main' || -z $vicmd ]]; then
      print -n $EMACS_MODE_PROMPT
   else
      print -n $vicmd
   fi
   print %f
}

prompt_todo() {
   TODO=$(cat $TODO_PATH)
   if [[ -z $TODO ]]; then
      print "  * you current have no todo's"
   else
      for line in ${(ps:\n:)TODO}; do
         print "  * $line"
      done
   fi
}

prompt_steamline_setup() {
   export PS1='
%F{105}Sphe M%f [ %0(?.%F{111}.%F{197})%2d%f ]
%F{243}$(prompt_todo)%f
-%f%(!.#.$)%f '

   export PS2="  %F{111}>%f "
   export PS3="  %F{111}>%f "
   export PS4="  %F{111}>%f "
   export PS5="  %F{111}>%f "
   export RPS1='$(prompt_vi_mode)'
}

prompt_opts=(cr subst percent sp)
prompt_steamline_setup
