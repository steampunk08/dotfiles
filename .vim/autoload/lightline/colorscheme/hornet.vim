" =============================================================================
" Filename: autoload/lightline/colorscheme/molokai.vim
" Author: challsted
" License: MIT License
" Last Change: 2016/11/17 00:27:58.
" =============================================================================
"
let s:chartreuse = ['#afff00', 154]
let s:hotpink    = ['#d7005f', 161]
let s:lightblue  = ['#87afff', 111]
let s:banana     = ['#ffff00', 226]
let s:mustard    = ['#ffd700', 220]
let s:blurple    = ['#8787af', 105]
let s:coffee     = ['#875f5f', 95]
let s:burn       = ['#ff0000', 196]
let s:navy       = ['#5f87af', 67]
let s:teal       = ['#00afaf', 37]
let s:lightgray  = ['#949494', 246]
let s:gray       = ['#6c6c6c', 242]
let s:midgray    = ['#585858', 240]
let s:dimgray    = ['#303030', 236]
let s:darkgray   = ['#1c1c1c', 234]
let s:white      = ['#ffffff', 15]
let s:black      = ['#080808', 232]
let s:red        = ['#d75f5f', 167]
let s:peach      = ['#ffd7af', 223]
let s:orange     = ['#ff5f00', 202]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ 
\  [ s:darkgray , s:mustard ],
\  [ s:mustard  , s:darkgray ],
\  [ s:lightgray, s:dimgray ]]

let s:p.normal.middle = [ [ s:orange, s:darkgray ] ]
let s:p.normal.right = [
\  [ s:darkgray , s:mustard ],
\  [ s:mustard  , s:darkgray ],
\  [ s:lightgray, s:dimgray ]]

let s:p.tabline.right = [
\  [ s:darkgray, s:mustard ],
\  [ s:white   , s:dimgray ]]

" let s:p.normal.error = [ [ s:hotpink, s:darkgray ] ]
" let s:p.normal.warning = [ [ s:banana, s:darkgray ] ]
" let s:p.insert.left = [ [ s:darkgray, s:chartreuse ], [ s:chartreuse, s:darkgray ] ]
" let s:p.visual.left = [ [ s:darkgray, s:banana ], [ s:banana, s:darkgray ] ]
" let s:p.replace.left = [ [ s:darkgray, s:red ], [ s:red, s:darkgray ] ]
" let s:p.inactive.left =  [ [ s:hotpink, s:darkgray ], [ s:white, s:darkgray ] ]
" let s:p.inactive.middle = [ [ s:gray, s:darkgray ] ]
" let s:p.inactive.right = [ [ s:white, s:hotpink ], [ s:hotpink, s:darkgray ] ]
" let s:p.tabline.left = [ [ s:black, s:coffee ] ]
" let s:p.tabline.middle = [ [ s:hotpink, s:darkgray] ]
" let s:p.tabline.right = copy(s:p.normal.right)
" let s:p.tabline.tabsel = [ [ s:darkgray, s:hotpink ] ]

let g:lightline#colorscheme#hornet#palette = lightline#colorscheme#flatten(s:p)
