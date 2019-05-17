filetype off
call vundle#begin('~/vim-bundle/')

" plugin manager
Plugin 'VundleVim/Vundle.vim'

" operators & motions (extending vim)
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'kshenoy/vim-signature'
Plugin 'junegunn/vim-easy-align'

" syntax additionals
Plugin 'tikhomirov/vim-glsl'
Plugin 'ap/vim-css-color'
Plugin 'dag/vim-fish'
Plugin 'pprovost/vim-ps1'
Plugin 'valloric/matchtagalways'
Plugin 'octol/vim-cpp-enhanced-highlight'

" colorscheme
" Plugin 'steampunk08/vim-steampunklights'

" navigation
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-startify'
Plugin 'mhinz/vim-signify'

" editing
Plugin 'scrooloose/vim-markdown-toc'
Plugin 'vimwiki/vimwiki'

" completion
Plugin 'jiangmiao/auto-pairs'
Plugin 'shougo/deoplete.nvim'
Plugin 'shougo/neosnippet.vim'

" other
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-scriptease'
Plugin 'godlygeek/tabular'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'DrawIt'
Plugin 'mbbill/undotree'
Plugin 'itchyny/lightline.vim'
Plugin 'benmills/vimux'
Plugin 'mattn/emmet-vim'

" disabled
" Plugin 'shougo/vimproc.vim'
" Plugin 'marcweber/vim-addon-mw-utils'
" Plugin 'tpope/vim-abolish'
" Plugin 'raimondi/delimitmate'

call vundle#end()
filetype plugin indent on

nnoremap gopi :PluginInstall<cr>
