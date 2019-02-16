" =============================================================================
" Filename: autoload/lightline/colorscheme/hornet.vim
" Author: Sphe M
" Last Change: 10 Feb 2019
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
let s:orange     = ['#ff5f00', 202]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ 
\  [ s:darkgray , s:mustard  ],
\  [ s:mustard  , s:darkgray ],
\  [ s:lightgray, s:dimgray  ]]

let insert_mode = deepcopy(s:p.normal.left)
let insert_mode[0][1] = s:blurple

let s:p.insert.left = insert_mode
let s:p.insert.right = deepcopy(insert_mode)

let visual_mode = deepcopy(s:p.normal.left)
let visual_mode[0][1] = s:chartreuse

let s:p.visual.left = visual_mode
let s:p.visual.right = deepcopy(visual_mode)

let s:p.normal.middle = [[ s:orange, s:darkgray ]]
let s:p.normal.right = deepcopy(s:p.normal.left)

let s:p.tabline.right = [
\  [ s:darkgray, s:mustard ],
\  [ s:white   , s:dimgray ]]

let g:lightline#colorscheme#hornet#palette = lightline#colorscheme#flatten(s:p)
