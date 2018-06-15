# ZSH CONFIG - ZSTYLES

# generate $LS_COLORS
eval $(dircolors -b ~/.termux/.dircolors)

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
zstyle ':completion:*' path-completion true
if [ -f $HOME/.w3m/history ]; then
   zstyle ':completion:*' urls $HOME/.w3m/history
fi
#zstyle ':completion:*' select-scroll 
