# ZSH CONFIG - WIDGETS & BINDINGS
autoload -Uz edit-command-line

function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

TRAPWINCH() {
  zle &&  zle -R
}

zle -N zle-keymap-select
zle -N edit-command-line

bindkey -v
bindkey -M vicmd 'v' edit-command-line

bindkey "^?" backward-delete-char
bindkey "^h" backward-delete-char
bindkey "^w" vi-backward-kill-word

bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^r" history-incremental-search-backward
bindkey "^n" history-search-forward
bindkey "^p" history-search-backward
bindkey "^l" forward-char
bindkey "^f" forward-char
bindkey "^b" backward-char

bindkey "^[f" forward-word
bindkey "^[b" forward-word

function open-music()
{
   addon music
}

zle -N open-music
# FIXME
#bindkey "^DM" open-music
