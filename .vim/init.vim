source ~/dotfiles/.vimrc

" configs references "gf"
" $XDG_CONFIG_HOME/nvim/after/plugin/plugin_configs.vim
" $XDG_CONFIG_HOME/nvim/autoload/lightline/colorscheme/hornet.vim
" $HOME/vim-steampunklights
" $HOME/vim-swapitems
source ~/plugins.vim
noremap K <nop>

" Personal Plugins
set runtimepath+=~/vim-steampunklights
set runtimepath+=~/vim-swapitems
set guifont=Monospace\ 9
" set runtimepath+=~/qt5.vim
" set runtimepath+=~/asm_arm.vim

call pathogen#infect("~/vim-infestation/{}")

" Desktop settings
nnoremap <c-z> u
inoremap <c-z> u

inoremap <c-left> <c-w>h
inoremap <c-right> <c-o>b

noremap ga <Plug>(EasyAlign)

nmap <c-?> =c

augroup JAVA_PREFS
   autocmd!
   autocmd Filetype java setlocal iskeyword+=.
augroup END
