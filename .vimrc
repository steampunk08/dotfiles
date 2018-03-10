" Sphe M | Steampunk08 vimrc 2

let g:disarmed = v:false
if !exists('vimrc_has_been_sourced') || g:disarmed
   echo "So much better now... L.E.L"
   set rtp+=~/vim-steampunklights

   let mapleader = "-"
   let maplocalleader = "="
   let vimrc_has_been_sourced = "2.0.1"

   let VIMRC_MINIMAL_SETUP_MODE = v:false
   " call pathogen#infect()
endif

" NOTE: section is reserved for statusline/tabline configuration
" statusline code {{{
" mode {{{
function! Mode()
   let m = mode()
   if m == 'i'
      return 'insert'
   elseif m == 'R'
      return 'replace'
   elseif m =~ '\v\cv|'
      return 'visual'
   elseif m == '\v\cs|r'
      return 'select'
   elseif m == 'c'
      return 'cmdline'
   else
      return 'normal'
   endif
endfunction
" }}}
" modifiable {{{
function! Modifiable()
   if !&modifiable || &readonly
      return nr2char(57506) . ' '
   else
      return ''
   endif
endfunction
" }}}
" modflag {{{
function! ModFlag()
   return &modified ? ' *' : ''
endfunction
" }}}
" getfsize {{{
function! s:pad(number)
   return printf("%03i", a:number)
endfunction

function! GetFSize()
   let size = getfsize(expand('%'))
   return size < 0 ? 0 : size
endfunction
" }}}
" wordcount {{{
function! WordCount()
   let cmode = mode()
   if cmode =~# '\vV|v|s|S'
      let vwords = wordcount()['visual_words']
      if vwords != ''
         return vwords
      else
         return 0
      endif
   else
      return wordcount()['words']
   endif
endfunction
" }}}
" synname {{{
function! SynName()
   let synname = synIDattr(synID(line("."), col("."), 1), "name")
   return empty(synname) ? "Normal" : synname
endfunction
" }}}
" statusline {{{
function! Statusline()
   highlight C1  ctermbg=154 ctermfg=16
   highlight C12 ctermfg=154 ctermbg=236

   highlight C2  ctermbg=236 ctermfg=167
   highlight C23 ctermfg=236 ctermbg=234

   highlight C3  ctermbg=234 ctermfg=247
   highlight C4 ctermfg=234 ctermbg=236

   set statusline=%#C1#\ %{toupper(Mode())}\ %#C12#
   set statusline+=%#C2#\ %{Modifiable()}%t%{ModFlag()}\ %#C23#
   set statusline+=%#C3#\ %{SynName()}\ 
   set statusline+=%=%#C3#%{&filetype}\ |
   set statusline+=%#C23#%#C2#\ %c:%l\ %#C12#%#C1#\ |
   set statusline+=%{GetFSize()}\ \|\ words\ %{WordCount()}\ |
endfunction
" }}}
call Statusline()
" }}}
" tabline code {{{
" name with padding {{{
function! NameWithPadding()
   let s:sub = { x -> substitute(x, '\v.+/', '', '') }
   let n = 0
   let buflist = tabpagebuflist(tabpagenr())

   for i in range(1, tabpagenr('$'))
      let l:bnlen = len(s:sub(bufname(i)))
      if l:bnlen > n
         let n = l:bnlen
      endif
   endfor
   let l:bname = expand("%:t")
   let l:pad = ''
   let l:len = len(l:bname)

   if l:len > n
      for x in range(n - l:len)
         let l:pad .= ' '
      endfor
   endif
   return '%t' . l:pad
endfunction
" }}}
" tabline {{{
function! Tabline()
   "let s = '%#C1# ' . NameWithPadding() . ' '
   let s = '%#C1# %t '
   for i in range(tabpagenr('$'))
      let n = i + 1

      if n == tabpagenr()
         let s .= '%#C3#'
      else
         let s .= '%#C2#'
      endif
      let s .= '%' . n . 'T'
      let s .= n > tabpagenr() + 1 ? '%#C4#|%#C2#' : ''
      let s .= ' ' . n . ' '
      let s .= n < tabpagenr() - 1 ? '%#C4#|' : ''
   endfor
   let s .= '%#C3#%T'

   if tabpagenr('$') > 1
      let s .= '%=%#TabLine#%999X%#C2# x %#C1# close '
   endif

   return s
endfunction
" }}}
set tabline=%!Tabline()
" }}}

" NOTE: section is reserved for vim builtin settings
" vim settings {{{
set shell=zsh
set nocompatible showcmd wildmenu
set numberwidth=3 number relativenumber
set encoding=utf8 backspace=indent,eol,start
set showtabline=2 laststatus=2 cursorline
set softtabstop=3 tabstop=3 expandtab shiftwidth=3
set history=450 undodir=~/.vim/undo
set incsearch hlsearch
set smartcase smarttab smartindent autoread
set t_Co=256 mouse=a
set signcolumn=auto foldcolumn=0
set splitright
set lazyredraw
" }}}

" NOTE: section is reserved for user defined functions / plugins of a small size
" utillities {{{
" Show {{{
command! Show call Show('\s+$')
command! NoShow highlight! link ShowColour Normal

function! Show(pattern)
   highlight! link ShowColour Error
   execute 'match ShowColour /\v' . a:pattern . '/'
   try 
      execute 'normal! /\v' . a:pattern  . "\<cr>"
   catch /E486/
   endtry
endfunction
" }}}
" Squeeze {{{
let g:squeeze_subto = ''

command! -nargs=* -bang Squeeze call Squeeze(<q-args>, <bang>0)
function! Squeeze(...)
   if !exists('g:squeeze_subto')
      let g:squeeze_subto = ''
   endif
   if !a:0 || a:1 == ''
      let pattern = '\s+$'
   else
      let pattern = a:1
   endif
   if a:0 == 2 && a:2
      let flags = 'g'
   else
      let flags = ''
   endif
   for i in range(0, line('$'))
      call setline(i, substitute(getline(i), '\v' . pattern, g:squeeze_subto, flags))
   endfor
endfunction
" }}}
" Build {{{
function! Build(language)
   if a:language == "ruby"
      let l:cmd = ':!' . a:language
   elseif a:language == "python"
      let l:cmd = ':!' . a:language . '2'
   elseif a:language == "javascript"
      let l:cmd = ':!node'
   elseif a:language == "vim"
      let l:cmd = ':source'
   endif

   execute 'noremap <buffer> <localleader>r :w<cr>' . l:cmd . ' %<cr>'
endfunction
" }}}
" GotoLink {{{
function! GotoLink()
   if SynName() == "markdownLinkText"
      let saved_register = @l
      normal! mLf(l"lyi)`L
      let link = @l

      if link =~ '\v(\.com|\.co|https|http)'
         execute ':!w3m ' . link
      endif
   endif
endfunction

nnoremap <leader>g :call GotoLink()<cr>
" }}}
" QuickRun {{{
function! QuickRun(force_register)
   if !empty(a:force_register)
      execute "normal! :" . a:force_register . "\<cr>"
      return
   endif
   let save_a = @a
   execute "normal! mp0\"ay$`p:\<c-r>a\<cr>"
   let @a = save_a

endfunction

nnoremap <localleader><localleader> :call QuickRun('')<cr>
" }}}
" }}}

execute 'iabbrev toc() ' . strftime('%-d %b %Y')

" NOTE: section is reserved for misc. mappings
" mappings {{{
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ez :tabedit ~/.zshrc<cr>
nnoremap <localleader>r :w<cr>:so %<cr>
" movement mappings {{{
noremap H ^
noremap L $

" line wrap compatible movements
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> 0 g0
nnoremap <silent> $ g$

" drawit android compatiblity
map <c-h> <left>
map <c-k> <up>
map <c-j> <down>
map <c-l> <right>
" }}}
" utility {{{
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nmap ; mG$a;<esc>`G

inoremap <c-c> <c-o>yy<c-o>p<c-o>$
nnoremap Y y$
nnoremap p pmQ=l`Q
nnoremap P P=l
nnoremap <space> za

" commandline
cnoremap [6~ <s-tab>
" }}}
" }}}

" NOTE: section is reserved for misc. autocommands
" autocmd {{{
augroup VIMSCRIPT
   autocmd FileType vim set foldmethod=marker foldlevel=0
   autocmd Filetype help nnoremap <buffer> <cr> <c-]>
augroup END

augroup TMUX
   autocmd Filetype tmux
      \ nnoremap <buffer> <localleader>r :w<cr>:Tmux source-file ~/.tmux.conf<cr>
augroup END

augroup SETTING_FILETYPES
   autocmd!
   autocmd BufNewFile,BufRead prompt_*_setup setfiletype zsh
   autocmd BufNewFile,BufRead *.vifm setfiletype vim
augroup END

augroup BUILDING_FILES
   autocmd!
   autocmd FileType ruby call Build("ruby")
   autocmd FileType vim call Build("vim")
   autocmd FileType python call Build("python")
   autocmd FileType javascript call Build("javascript")
augroup END

if !has('gui_running')
   set ttimeoutlen=10
   augroup FASTER_ESCAPE
      autocmd!
      au InsertEnter  * set timeoutlen=0
      au InsertLeave  * set timeoutlen=1000
      au CmdlineEnter * set timeoutlen=0
      au CmdlineLeave * set timeoutlen=1000
   augroup END
endif
" }}}

" NOTE: section is reserved for user defined commands
" commands {{{
command! We w | e
" }}}

" NOTE: section is reserved for plugin settings and mappings
" plugin assests {{{
if !exists("VIMRC_MINIMAL_SETUP_MODE") || !VIMRC_MINIMAL_SETUP_MODE
" vundle {{{
filetype off
call vundle#begin('~/vim-bundle/')

Plugin 'VundleVim/Vundle.vim'
"Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'godlygeek/tabular'
Plugin 'easymotion/vim-easymotion'
"Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'majutsushi/tagbar'
Plugin 'pangloss/vim-javascript'
Plugin 'ervandew/supertab'
Plugin 'DrawIt'
Plugin 'benmills/vimux'
Plugin 'tpope/vim-tbone'
"Plugin 'rhysd/open-pdf.vim'
Plugin 'tpope/vim-obsession'
Plugin 'nanotech/jellybeans.vim'
Plugin 'morhetz/gruvbox'
"Plugin 'itchyny/lightline.vim'
Plugin 'lokaltog/vim-distinguished'
"Plugin 'honza/vim-snippets'
"Plugin 'Shougo/neocomplcache'
"Plugin 'Shougo/neosnippet'
Plugin 'Shougo/vimshell.vim'
"Plugin 'Shougo/neosnippet-snippets'
"Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
Plugin 'kana/vim-textobj-user'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-speeddating'
Plugin 'shougo/vimproc.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-rhubarb'
Plugin 'mbbill/undotree'
Plugin 'airblade/vim-gitgutter'
Plugin 'houtsnip/vim-emacscommandline'
Plugin 'tpope/vim-markdown'
Plugin 'mhinz/vim-startify'
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'vimwiki/vimwiki'
Plugin 'pprovost/vim-ps1'
Plugin 'stephpy/vim-yaml'
Plugin 'tikhomirov/vim-glsl'
Plugin 'tpope/vim-scriptease'
Plugin 'scrooloose/vim-markdown-toc'
Plugin 'junegunn/vim-easy-align'
Plugin 'junegunn/vim-emoji'
Plugin 'ap/vim-css-color'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'oplatek/Conque-Shell'
"Plugin 'pangloss/vim-vascriptin'

"Plugin 'file:///~/.vim/bundle/airline'
nnoremap gopi :PluginInstall<cr>

call vundle#end()
filetype plugin indent on
" }}}
" nerd commenter {{{
map =c -c<space>
" }}}
" nead tree {{{
" }}}
" tbone {{{
" }}}
" lightline {{{
" let g:lightline = { 'colorscheme': 'jellybeens' }
" let g:lightline.component = {}
" let g:lightline.component.readonly = "%{&readonly ? '' : ''}"
" let g:lightline.component.higroup = "%{StatuslineCurrentHighlight()}"

"let g:lightline.active = {}
"let g:lightline.active.left = [
   "\ ["mode", "paste"],
   "\ ["readonly", "filename", "modified"],
   "\ ["higroup"],
"\ ]

"let s:p.normal.left = [
" }}}
" startify {{{
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_bookmaks = [
   \ { '-': '~/vim-steampunklights/colors/steampunklights.vim' }
\ ]

function! StartifyOnUnamedBuffer()
   if expand('%') == "" && getfsize(expand('%:p')) > -1
      Startify
   endif
endfunction

let g:startify_padding_left = 3
let g:startify_custom_indices = map(range(97, 105), 'nr2char(v:val)')
let g:startify_custom_header = startify#fortune#boxed()
let g:startify_custom_footer =
   \ ['', "Vim is charityware. Please read ':help uganda'.", '']

augroup startify
   autocmd!
   autocmd BufEnter * call StartifyOnUnamedBuffer()
augroup END
" }}}
" vim shell {{{
augroup vim_shell
   autocmd FileType vimshell redraw!
augroup END
" }}}
endif
" }}}

try
   colorscheme steampunklights
catch /E185/
   colorscheme darkblue
endtry
nohlsearch

" NOTE: for any overiding settings which would conflict with plugin settings
" overides {{{

" get rid off annoying backward search in emacscmdline
if !exists("VIMRC_MINIMAL_SETUP_MODE") || !VIMRC_MINIMAL_SETUP_MODE
   if !empty(mapcheck("<c-r>", "c"))
      cunmap <c-r>
   endif
endif
" }}}

"redraw!
" vim:ts=3:sts=3:sw=3:et
