source ~/.vimrc

" configs references "gf"
" $XDG_CONFIG_HOME/nvim/after/plugin/plugin_configs.vim
" $XDG_CONFIG_HOME/nvim/autoload/lightline/colorscheme/hornet.vim
" $HOME/vim-steampunklights
" $HOME/vim-swapcase
source ~/plugins.vim
noremap K <nop>

" Personal Plugins
set runtimepath+=~/vim-steampunklights
set runtimepath+=~/vim-swapcase
" set runtimepath+=~/qt5.vim
" set runtimepath+=~/asm_arm.vim

call pathogen#infect("~/vim-infestation/{}")
