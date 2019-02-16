" SPHE M'S PLUGIN CONFIGS

" run asm
command! Asmrun :VimuxRunCommand "as -g -o " .expand("%:r").".o " .expand("%") . " && ld -o bin/".expand("%:r") . " ".expand("%:r").".o && bin/" .expand("%:r"). "; echo $?"
" easymotion
let g:EasyMotion_verbose = 0

" nerdcommenter {{{
map <localleader>c <plug>NERDCommenterToggle

let NERDSpaceDelims = 1
let NERDRemoveExtraSpaces = 1
" }}}
" deoplete {{{
if !exists('g:necovim#complete_functions')
   let g:necovim#complete_functions = {'Ref': 'ref#complete'}
endif

call deoplete#custom#option({
\   'ignore_sources': { '_': ['around'] },
\   'skip_chars': ['\', '(', ')'],
\   'auto_complete_delay': 80,
\   'smart_case': v:true,
\   'min_pattern_length': 2,
\   'max_lsit': 350,
\   'omni_patterns': {
\      'cpp':  ['[^. *\t]\(::\|\.\|->\)'],
\      'javascript':  ['[^. *\t]\.\w*'],
\      'xml':  ['</'],
\      'html': ['</'],
\   },
\   'sources': {
\      '_':   ['file', 'buffer', 'omni', 'member', 'syntax'],
\      'vim': ['file', 'buffer', 'vim'],
\   },
\ })

" \   'omni_patterns': { 'java': '[^. *\t]\.\w*', 'xml': '</'},
call deoplete#custom#var('buffer', 'require_same_filetype', v:false)
call deoplete#custom#var('member', 'prefix_patterns', {'vim': ['#', ':', '\.']})

function! s:return_func() abort
   return deoplete#close_popup() . "\<CR>"
endfunction

inoremap <expr> <cr> <SID>return_func()

call deoplete#enable()
call deoplete#initialize()
" }}}

" colorizer
let g:colorizer_auto_filetype='xml,css,html'

" neosnippet {{{
nnoremap [N :NeoSnippetEdit -split<cr>

let g:neosnippet#disable_runtime_snippets = {
\   '_' : 1,
\ }
let g:neosnippet#snippets_directory = $XDG_CONFIG_HOME . '/nvim/snippets'

map <tab> <Plug>(neosnippet_expand_or_jump)

function! NextCompletionOrExpansion()
   if pumvisible()
      return "\<c-n>"
   elseif neosnippet#expandable_or_jumpable()
      return "\<plug>(neosnippet_expand_or_jump)"
   endif
   return "\<tab>"
endfunction

imap <expr><tab> NextCompletionOrExpansion()
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
let g:startify_custom_header = startify#fortune#boxed()
let g:startify_custom_footer =
\ ['', "Vim is charityware. Please read ':help uganda'.", '']

augroup startify
   autocmd!
   autocmd BufEnter * call StartifyOnUnamedBuffer()
augroup END
" }}}
" undotree {{{
nnoremap <silent> [u :UndotreeToggle<cr>

let g:undotree_SplitWidth = 28
let g:undotree_WindowLayout = 2
" }}}
" nerdtree {{{
nnoremap <silent> [n :NERDTreeToggle<cr>

let NERDTreeShowHidden = 1
let NERDTreeDirArrowCollapsible = "-"
let NERDTreeDirArrowExpandable = "+"

function! Quit()
   return
endfunction

call NERDTreeAddMenuItem({
\   'text': '(q)uit menu',
\   'shortcut': 'q',
\   'callback': 'Quit'
\})

call NERDTreeAddMenuSeparator()

function! AddDirToRTP()
   let node = g:NERDTreeFileNode.GetSelected()
   if node.path.isDirectory
      execute 'set rtp+=' . node.path.str()
      echo 'added directory to &rtp'
   else
      echohl Operator
      echo 'ERROR: this operation applies only to directories'
      echohl Normal
   endif
endfunction

call NERDTreeAddMenuItem({
\   'text': '(a)dd directory to &rtp',
\   'shortcut': 'a',
\   'callback': 'AddDirToRTP',
\ })

function! SourceFile()
   let node = g:NERDTreeFileNode.GetSelected()
   if node.path.isDirectory
      echohl Operator
      echo 'ERROR: this operation applies only to files'
      echohl Normal
   else
      execute 'source ' . node.path.str()
   endif
endfunction

call NERDTreeAddMenuItem({
\   'text': '(s)ource vim file',
\   'shortcut': 's',
\   'callback': 'SourceFile',
\ })
" }}}
" signature {{{
let g:SignatureMap = {
\ 'Leader'             :  "m",
\ 'PlaceNextMark'      :  "m,",
\ 'ToggleMarkAtLine'   :  "m.",
\ 'PurgeMarksAtLine'   :  "m-",
\ 'DeleteMark'         :  "dm",
\ 'PurgeMarks'         :  "m<Space>",
\ 'PurgeMarkers'       :  "m<BS>",
\ 'GotoNextLineAlpha'  :  "']",
\ 'GotoPrevLineAlpha'  :  "'[",
\ 'GotoNextSpotAlpha'  :  "`]",
\ 'GotoPrevSpotAlpha'  :  "`[",
\ 'GotoNextLineByPos'  :  "]'",
\ 'GotoPrevLineByPos'  :  "['",
\ 'GotoNextSpotByPos'  :  "]`",
\ 'GotoPrevSpotByPos'  :  "<pagedown>",
\ 'GotoNextMarker'     :  "]-",
\ 'GotoPrevMarker'     :  "[-",
\ 'GotoNextMarkerAny'  :  "]=",
\ 'GotoPrevMarkerAny'  :  "[=",
\ 'ListBufferMarks'    :  "m/",
\ 'ListBufferMarkers'  :  "m?"
\ }
" }}}
" lightline {{{
" SynName() {{{
function! SynName()
   let synname = synIDattr(synID(line("."), col("."), 1), "name")
   return empty(synname) ? "Normal" : synname
endfunction
" }}}
" Modifiable() {{{
function! Modifiable()
   return !&modifiable || &readonly ? nr2char(57506) : ''
endfunction
" }}}
" ModFlag() {{{
function! ModFlag()
   return &modified ? '*' : ''
endfunction
" }}}
" WordCount() {{{
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
" CharCount() {{{
function! Sum(array)
   return len(a:array)
endfunction

function! CharCount()
   let sum = 0
   if getfsize(expand("%")) > 10000
      return v:false
   endif
   for i in getline(0, '$')
      let sum += Sum(i) + 1
   endfor
   return sum == 1 ? 0 : sum
endfunction
" }}}
" FileName() {{{
function! FileName()
   return empty(expand('%:t')) ? 'no name' : expand('%:t')
endfunction
" }}}
" TabName() {{{
function! s:pad(word, n)
   let padding = ''
   for i in range(a:n - len(a:word))
      let padding .= ' '
   endfor
   return a:word . padding
endfunction

function! TabName()
   let fname = empty(expand('%:t')) ? 'no name' : expand('%:t')
   let length = len(fname)

   for n in range(tabpagenr('$'))
      for i in tabpagebuflist(n + 1)
         try
            let curlen = len(split(bufname(i), g:path_separator)[-1])
         catch
            let curlen = 0
         endtry
         if curlen > length
            let length = curlen
         endif
      endfor
   endfor
   return s:pad(fname, length)
endfunction
" }}}
" TabNextName() {{{
function! s:strip(name)
   if empty(a:name)
      return "no name"
   endif
   return split(a:name, g:path_separator)[-1]
endfunction

function! TabNextName() abort
   let s:bname = { x -> bufname(tabpagebuflist(x)[0]) }
   let name_1 = s:bname(tabpagenr() + 1)
   let name_2 = s:bname(1)

   if tabpagenr('$') == 1
      return ''
   endif
   if empty(name_1) && tabpagenr() == tabpagenr('$')
      return s:strip(name_2)
   elseif empty(name_1) 
      return 'no name'
   endif
   return s:strip(name_1)
endfunction
" }}}
" TabNumbers() {{{
function! TabNumbers()
   let s = ''
   for i in range(tabpagenr('$'))
      let n = i + 1

      if n == tabpagenr()
         let s .= '%#TabnumCurrent#'
      else
         let s .= '%#Tabnum#'
      endif
      let s .= '%' . n . 'T'
      let s .= n > tabpagenr() + 1 ? '%#TabnumSep#|%#Tabnum#' : ''
      let s .= ' ' . n
      if i != tabpagenr('$') - 1 
         let s .= ' '
      endif
      let s .= n < tabpagenr() - 1 ? '%#TabnumSep#|' : ''
   endfor
   let s .= '%T'

   return s
endfunction
" }}}

let g:lightline = {
\  'active': {
\     'left': [ [ 'mode', 'paste' ],
\               [ 'modifiable', 'filename', 'modflag' ],
\               [ 'synname' ] ],
\     'right': [ [ 'atchar', 'wordcount' ],
\                [ 'lineinfo' ],
\                [ 'filetype' ] ],
\     },
\  }
let g:lightline["tabline"] = {
\  'left': [ [ 'tabname' ], [ 'tabnums' ], [ 'tabnextname' ] ],
\  'right': [ [ 'closelabel' ], [ 'close' ] ]
\ }

let g:lightline["component"] = {
\  'wordcount': "%{'words ' . WordCount()}",
\  'lineinfo': '%c:%l',
\  'tabname': '%t',
\  'atchar': '%o',
\  'closelabel': 'close'
\ }

let g:lightline["component_function"] = {
\  'synname': 'SynName',
\  'modifiable': 'Modifiable',
\  'modflag': 'ModFlag',
\  'charcount': 'CharCount',
\  'tabname': 'TabName',
\  'tabnextname': 'TabNextName',
\  'filename': 'FileName',
\ }

let g:lightline["component_visible_condition"] = {
\ 'ModFlag': '&modified && !(!&modifiable || &readonly)',
\ 'modifiable': '!&modifiable||&readonly',
\ }

let g:lightline["component_expand"] = {
\  'tabnums': 'TabNumbers',
\ }

" $XDG_CONFIG_HOME/nvim/autoload/lightline/colorscheme/hornet.vim
let g:lightline.colorscheme = "hornet"
" }}}
" steampunklights {{{
" personal statusline
try
   colorscheme steampunklights

   call Steampunklights.Highlight({
   \   'Tabnum':        ["black", "midgray"],
   \   'TabnumCurrent': ["lightgray", "darkgray"],
   \   'TabnumSep':     ["black", "midgray"],
   \ },'Tabnum')

catch /E185/
   colorscheme darkblue
endtry
" }}}
" javaapi {{{
augroup JAVA_FILE_TYPE
   autocmd!
   autocmd BufNewFile,BufRead *.java setl omnifunc=javaapi#complete
augroup END

let g:javaapi#delay_dirs = [
\ 'java-api-junit',
\ 'java-api-android',
\ ]
" }}}
" omni cpp complete {{{
" FIXME
let g:ctags_not_found = 0
if exists('g:ctags_not_found') && !g:ctags_not_found
   augroup OMNI_CPP_COMPLETE
      autocmd!
      autocmd BufWritePost *.cpp silent !ctags -u --c++-kinds=+p --fields=+iaS --extras=+q **/*.cpp
   augroup END
endif
" }}}
