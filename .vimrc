" Sphe M | Steampunk08 vimrc 2

let g:disarmed = v:false
if !exists('VIMRC_HAS_BEEN_SOURCED') || g:disarmed
   let maplocalleader = "="
   let mapleader = "-"

   let VIMRC_MINIMAL_SETUP_MODE = v:false
   let VIMRC_HAS_BEEN_SOURCED = "2.1.2"

endif
let g:vim_indent_cont = 0
let g:path_separator = "/"

" NOTE: section is reserved for vim builtin settings
" vim settings {{{
set shell=$SHELL
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
set splitright fillchars+=fold:-
set completeopt=menu
set lazyredraw runtimepath+=.
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
            \ "python": "python3",
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
" Depends on "w3m" terminal web browser
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

function! Colourize(name, timer)
   execute "hi " . a:name . " ctermfg=" . g:counter % 256
   redraw!
   let g:counter += 1
endfunction

let g:counter = 0
command! -nargs=1 Colourize let g:counter=0 | let colourize = timer_start(100, funcref("Colourize", [<q-args>]), {'repeat': -1})
" }}}
" Tease (colorcheme tease) {{{
command! Tease call Tease()
let g:tease_color_num = 197
let g:tease_attribs = "none"

function! Tease()
   while v:true
      silent let var = input("> ")
      if empty(var)
         echo 'Teasing done !'
         return
      elseif var =~ '\.c\%[olor] \d*'
         let args = split(var)[1:]
         let g:tease_color_num = str2nr(args[0]) % 256

         if !empty(args[1:])
            let g:tease_attribs = join(args[1:], ",")
         endif
         silent let var = input("> ")
      endif
      execute "hi " . var .
            \ " ctermfg=" . g:tease_color_num . 
            \ " cterm=" . g:tease_attribs
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
   endfor
endfunction
" }}}
" Goto File (extension) {{{
function! GotoFile(filename)
   let filename = expand(a:filename)
   if file_readable(filename)
      execute "tabedit " . a:filename
   else
      if file_readable(filename . ".qml")
         execute "tabedit " . filename . ".qml"
         return
      endif
      echoerr "E447: Can't find \"" . filename . "\" in path"
   endif
endfunction

nnoremap <silent> gf :call GotoFile(expand("<cfile>"))<cr>
" }}}
" CreateFold() {{{
function! CreateFold()
   execute "normal! \<esc>`>o".'"'.
      \ " \<esc>3a}\<esc>`<O".'"'.
      \ " \<esc>3a{\<esc>bhi "
endfunction

vnoremap <c-f> :call CreateFold()<cr>
" }}}
" }}}

" NOTE: section is reserved for misc. mappings
" mappings {{{
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>ez :tabedit ~/.zshrc<cr>
nnoremap <leader>eb :tabedit ~/.bashrc<cr>
nnoremap <leader>ep :tabedit $XDG_CONFIG_HOME/nvim/after/plugin/plugin_configs.vim<cr>

nnoremap <leader>sv :source $MYVIMRC<cr>
"nnoremap <localleader>r :w<cr>:so %<cr>
nnoremap gv v$
nnoremap G G$
" movement mappings {{{
noremap H ^
noremap L $

" line wrap compatible movements
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> 0 g0
nnoremap <silent> $ g$

" easy window navigation
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-l> <c-w>l
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
   autocmd!
   autocmd FileType vim setlocal foldmethod=marker foldlevel=0
   autocmd Filetype help nnoremap <buffer> <cr> <c-]>
   autocmd Filetype vifm setfiletype vim
augroup END

augroup FILETYPE_SPERCIFIC
   autocmd!
   autocmd Filetype zsh,sh setlocal iskeyword+=-
   autocmd Filetype help setlocal iskeyword+=- iskeyword+=# iskeyword+=:
   autocmd Filetype help nmap <bs> <c-o>
   autocmd Filetype html setlocal matchpairs-=<:>
   autocmd Filetype kivy setlocal shiftwidth=4 commentstring=#%s
augroup END

augroup EDITOR_MODE
   autocmd Filetype markdown setlocal textwidth=78
   autocmd Filetype gitcommit setlocal spell
augroup END

augroup SETTING_FILETYPES
   autocmd!
   autocmd BufNewFile,BufRead prompt_*_setup setfiletype zsh
   " autocmd BufNewFile,BufRead *.vifm setfiletype vim
   " autocmd BufNewFile,BufRead *.fish setfiletype zsh
   autocmd BufNewFile,BufRead crontabs.* setfiletype crontab
augroup END

if !has('gui_running')
   set ttimeoutlen=10
   augroup FASTER_ESCAPE
      autocmd!
      autocmd InsertEnter  * set timeoutlen=0
      autocmd InsertLeave  * set timeoutlen=750

      try
         autocmd CmdlineEnter * set timeoutlen=0
         autocmd CmdlineLeave * set timeoutlen=750
      catch /E216/
      endtry
   augroup END
endif
" }}}

" NOTE: section is reserved for user defined commands
" commands {{{
command! We w | e
command! Cd execute 'cd ' . expand('%:h')
" }}}

syntax on
"redraw!
" vim:ts=3:sts=3:sw=3:et
