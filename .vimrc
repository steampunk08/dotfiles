" Sphe M | Steampunk08 vimrc 2

let g:disarmed = v:false
if !exists('VIMRC_HAS_BEEN_SOURCED') || g:disarmed
   set runtimepath+=~/vim-steampunklights

   let maplocalleader = "="
   let mapleader = "-"

   let VIMRC_MINIMAL_SETUP_MODE = v:false
   let VIMRC_HAS_BEEN_SOURCED = "2.0.1"
   "call pathogen#infect()
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
"
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
   set statusline+=%#C3#\ %{SynName()}\ |
   set statusline+=%=%#C3#\ %{&filetype}\ |
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
set lazyredraw fillchars=stlnc:x 
"set iskeyword+=-
" }}}

" NOTE: section is reserved for user defined functions / plugins of a small size
" utillities {{{
" Show {{{
command! Show call Show('\s+$')
command! NoShow highlight! link ShowColour Normal

function! Show(pattern)
   " NOTE: arguments [pattern]
   "       marks all occurances of pattern with Error
   "       highlight group
   highlight! link ShowColour Error
   execute 'match ShowColour /\v' . a:pattern . '/'
   try
      execute 'normal! mogg/\v' . a:pattern  . "\<cr>`ozz"
   catch /E486/
   endtry
endfunction
" }}}
" Squeeze {{{
let g:squeeze_subto = ''

command! -nargs=* -bang Squeeze call Squeeze(<q-args>, <bang>0)
function! Squeeze(...)
   " NOTE: arguments [pattern] [scope of replacement (g|)]
   "       removes the first occurance of [pattern] in each
   "       line if arg 2 is false or is null otherwise all
   "       occurances of [pattern] are replaced with g:squeeze_subto
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
function! Build()
   let build_maps = {
            \ "ruby": "ruby",
            \ "python": "python2",
            \ "javascript": "node",
            \ "zsh": "zsh",
            \ "sh": "bash",
            \ }

   let buildCmd = "source"
   for [ lang, cmd ] in items(build_maps)
      if &filetype == lang
         let buildCmd = '!' . cmd
         break
      endif
   endfor
   execute 'normal! :' . buildCmd . " %\<cr>"
endfunction
nnoremap <localleader>r :call Build()<cr>
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
" GetSynname {{{
nnoremap yid :let [@", @h] = [SynName(), SynName()]<cr>
" }}}
" Colourize (colorscheme tease) {{{
command! -nargs=* -bang Colourize call Colourize(<f-args>, <bang>0)

function! Colourize(...)
   let g:counter = 0
   let g:name = a:1
   if a:0 > 2
      echoerr 
   function! Callback(timer)
      let g:counter += 1
      execute "hi " . g:name . " ctermfg=" . g:counter
      redraw!
      sleep 200m
      if g:counter > 249
         let g:counter = 0
      endif
   endfunction
   if a:0 ==
   let colourize = timer_start(1, funcref("Callback"), {'repeat': -1})
endfunction
" }}}
" Tease (colorcheme tease) {{{
command! Tease call Tease()
let g:tease_color_num = 111

function! Tease()
   while v:true
      silent let var = input("> ")
      if empty(var)
         echo 'Teasing done !'
         return
      endif
      execute "hi " . var . " ctermfg=" . g:tease_color_num
      redraw!
      sleep 500m
   endwhile
endfunction
" }}}
" Reformat CSS {{{
command! ReformatCSS call ReformatCSS()
function! ReformatCSS()
   echo "re-formatting..."
   %s/{/{/g
   %s/;/;/g
   %s/}/}/g
   redraw!
   normal! gg=G
   echo "done re-formatting!"
endfunction
" }}}
" Tabe Buffers {{{
command! TabeBuffers call TabeBuffers() 
" FIXME
"function! CompareBufs(num, bufname)
   "if bufname(a:num) == a:bufname
      "return v:true
   "endif
"endfunction

"function! BufAlreadyOpened(bufname)
"for i in range(tabpagenr('$'))
   "let tabbufs = tabpagebuflist(i)
   "if type(tabbufs) == type([])
      "for tabbufnum in tabbufs
         "return CompareBufs(tabbufnum, a:bufname)
      "endfor
   "endif
   "return CompareBufs(tabbufs, a:bufname)
"endfor
"endfunction

function! TabeBuffers()
   for Buffer in split(execute("buffers"), '\n')
      let bufname = split(Buffer, '"')[1]
      let bufstr  = substitute(Buffer, '\v +', '', 'g')

      if match(bufstr, '\d"') >= 0
         echo bufstr
         " call setline(352, bufstr)
         echo bufname
         execute 'tabe ' . bufname
      endif
      " 57%a"~/.vimrc"line347
      "if ! BufAlreadyOpened(bufname)
         execute 'tabe ' . bufname
      "endif
   endfor
endfunction
" }}}
" }}}

execute 'iabbrev now() ' . strftime('%-d %b %Y')

" NOTE: section is reserved for misc. mappings
" mappings {{{
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ez :tabedit ~/.zshrc<cr>
"nnoremap <localleader>r :w<cr>:so %<cr>
nnoremap gv v$
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
nmap <esc><esc> :nohlsearch<cr><esc>
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
   autocmd Filetype vifm setfiletype vim
augroup END

augroup FILETYPE_SPERCIFIC
   autocmd Filetype zsh,sh set iskeyword+=-
augroup END

augroup TMUX
   autocmd Filetype tmux
      \ nnoremap <buffer> <localleader>r :w<cr>:Tmux source-file ~/.tmux.conf<cr>
augroup END

augroup SETTING_FILETYPES
   autocmd!
   autocmd BufNewFile,BufRead prompt_*_setup setfiletype zsh
   autocmd BufNewFile,BufRead *.vifm setfiletype vim
   autocmd BufNewFile,BufRead *.fish setfiletype zsh
   autocmd BufNewFile,BufRead crontabs.* setfiletype crontab
augroup END

if !has('gui_running')
   set ttimeoutlen=10
   augroup FASTER_ESCAPE
      autocmd!
      autocmd InsertEnter  * set timeoutlen=0
      autocmd InsertLeave  * set timeoutlen=750
      autocmd CmdlineEnter * set timeoutlen=0
      autocmd CmdlineLeave * set timeoutlen=750
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
Plugin 'scrooloose/syntastic'
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
nmap <localleader>c <plug>NERDCommenterToggle
" }}}
" startify {{{
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_bookmaks = [
   \ { '-': '~/vim-steampunklights/colors/steampunklights.vim' }
\ ]

" FIXME: correct and make it work
function! StartifyOnUnamedBuffer()
   if expand('%') == "" && getfsize(expand('%:p')) > -1
      Startify
   endif
endfunction

let g:startify_padding_left = 3
let g:startify_custom_indices = range(0, 10)
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
