" Determine the terminal background.
" Initialize a colors dictionary.
let s:active_bg=(&background)
let s:colors = {}

let g:colors_name = "lamb"

" Color definitions.
" 'reds' is 'indianred1'
let s:colors.brick       = ['#800000', 1]
let s:colors.grey        = ['#a8a8a8', 248]
let s:colors.reds        = ['#ff0000', 9]
let s:colors.orchid      = ['#af5faf', 133]
let s:colors.lightorchid = ['#af87d7', 140]
let s:colors.densegrey   = ['#1c1c1c', 234]
let s:colors.deepgrey    = ['#121212', 233]
let s:colors.purple      = ['#5f005f', 53]
let s:colors.lightpink   = ['#ffafaf', 217]
let s:colors.darkred     = ['#af0000', 124]
let s:colors.darkmagenta = ['#87005f', 90]
let s:colors.riverblue   = ['#5fafff', 75]

" Highlighting function
" Cribbed from badwolf, guvbox.
function! s:highlight(target, fg, ...)
  " ... = bg, style.
  let histring = 'hi ' . a:target . ' '
  let fcolor = get(s:colors, a:fg)
 
  if strlen(a:fg)
    let histring .= 'guifg=' . fcolor[0] . ' ctermfg=' . fcolor[1] . ' '
  end
  
  if a:0 >= 1 && strlen(a:1)
    let bcolor = get(s:colors, a:1)
    let histring .= 'guibg=' . bcolor[0] . ' ctermbg=' . bcolor[1] . ' '
  endif 
  if a:0 >= 2 && strlen(a:2)
    let histring .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
  endif

  " Check that we actually got arguments.
  if histring != 'hi ' . a:target . ' '
    exe histring
  endif
endfunction

" Command line window. 
" Since this relies on autocommands, users can turn this off using
" g:wurm_cmdline
function! s:setCmd()
   au CmdLineEnter * call s:highlight('StatusLine', 'densegrey', 'reds')
   au CmdLineEnter * call s:highlight('StatusLineNC', 'densegrey', 'densegrey')
   au CmdLineEnter * call s:highlight('ModeMsg', 'reds')
   au CmdLineLeave * call s:highlight('Normal', 'brick', 'densegrey')
   au CmdLineLeave * call s:highlight('StatusLine', 'densegrey', 'orchid')
   au CmdLineLeave * call s:highlight('StatusLineNC', 'densegrey', 'grey')
   au CmdLineLeave * call s:highlight('ModeMsg', 'lightorchid')
endfunction

" Gundo support.
" Disabled for now.
" function! s:setGundo()
"   au BufEnter __Gundo__,__Gundo_Preview__ call s:highlight('StatusLine', 'densegrey', 'reds')
"   au BufLeave __Gundo__,__Gundo_Preview__ call s:highlight('StatusLine', 'densegrey', 'orchid')
" endfunction

" TODO: Complete dark implementation.
function! s:setDark()
  " Base colors.
  call s:highlight('Normal', 'brick', 'densegrey')
  call s:highlight('NonText', 'orchid')
  call s:highlight('comment', 'grey')
  call s:highlight('constant', 'orchid')
  call s:highlight('string', 'grey')
  call s:highlight('identifier', 'brick', 'densegrey', 'bold')
  call s:highlight('statement', 'lightpink')
  call s:highlight('define', 'lightorchid')
  call s:highlight('preproc', 'riverblue') 
  call s:highlight('type', 'lightorchid')
  call s:highlight('special', 'reds')
  call s:highlight('Underlined', '')
  call s:highlight('label', 'lightorchid')
  call s:highlight('operator', 'lightpink')
  call s:highlight('delimiter', 'brick')
  
  " Inline notifications. 
  call s:highlight('Todo', 'orchid', 'densegrey', 'bold')
  call s:highlight('Search', 'orchid', 'brick', 'bold')
  call s:highlight('IncSearch', '')
  call s:highlight('title', '')
 
  " Cursor
  call s:highlight('Cursor', 'darkmagenta', 'orchid')
  call s:highlight('CursorLine', '', '', 'NONE')
  call s:highlight('CursorLineNr', 'reds') 

  " Status line
  call s:highlight('StatusLine', 'densegrey', 'orchid')
  call s:highlight('StatusLineNC', 'densegrey', 'grey')
  
  " Windows
  call s:highlight('VertSplit', 'densegrey', 'densegrey')

  " Diff 
  call s:highlight('DiffChange', 'riverblue', 'densegrey')
  call s:highlight('DiffText', '')
  call s:highlight('DiffAdd', 'orchid', 'densegrey')
  call s:highlight('DiffDelete', 'reds', 'densegrey')

  " Folds
  call s:highlight('Folded', '')
  call s:highlight('FoldColumn', '')
  
  " Visual
  call s:highlight('Visual', 'reds', 'orchid')
  
  " Command window
  call s:highlight('ErrorMsg', 'reds', 'densegrey', 'bold')
  call s:highlight('WarningMsg', 'reds')
  call s:highlight('ModeMsg', 'lightorchid')
  call s:highlight('MoreMsg', 'riverblue')
  call s:highlight('Error', '')

  " Spelling
  call s:highlight('SpellLocal', '', '', 'italic')
  call s:highlight('SpellBad', '', 'densegrey', 'underline')
  call s:highlight('SpellCap', '', 'densegrey', 'underline')

  " Line gutter
  call s:highlight('LineNr', 'orchid', 'densegrey')
  call s:highlight('SignColumn', '', 'densegrey')

  if exists("g:wurm_cmdline") && g:wurm_cmdline != 0
    call s:setCmd()
  endif
endfunction

" TODO: Implement light theme.
function! s:setLight()
  " Base colors.
  call s:highlight('Normal', 'lightorchid')
  call s:highlight('NonText', 'riverblue')
  call s:highlight('comment', 'lightpink', 'darkmagenta', 'underline')
  call s:highlight('constant', 'orchid')
  call s:highlight('string', 'purple')
  call s:highlight('identifier', 'darkmagenta')
  call s:highlight('statement', 'darkred')
  call s:highlight('define', 'darkmagenta')
  call s:highlight('preproc', 'riverblue')
  call s:highlight('type', 'darkmagenta')
  call s:highlight('special', 'darkmagenta')
  call s:highlight('Underlined', '')
  call s:highlight('label', 'lightorchid')
  call s:highlight('operator', 'darkred')
  call s:highlight('delimiter', 'densegrey')
  
  " Inline notifications. 
  call s:highlight('Todo', 'orchid', 'lightpink', 'bold')
  call s:highlight('Cursor', 'darkmagenta')
  call s:highlight('Search', 'riverblue')
  call s:highlight('IncSearch', '')
  call s:highlight('LineNr', 'densegrey')
  call s:highlight('title', '')
  
  " Status line
  call s:highlight('StatusLine', 'purple', 'lightpink')
  call s:highlight('StatusLineNC', 'densegrey')
  
  " Windows
  call s:highlight('VertSplit', 'densegrey')

  " Diff 
  call s:highlight('DiffChange', 'riverblue')
  call s:highlight('DiffText', '')
  call s:highlight('DiffAdd', 'orchid')
  call s:highlight('DiffDelete', 'reds')

  " Folds
  call s:highlight('Folded', '')
  call s:highlight('FoldColumn', '')
  
  " Visual
  call s:highlight('Visual', 'purple', 'lightorchid')
  
  " Command window
  call s:highlight('ErrorMsg', 'reds')
  call s:highlight('WarningMsg', 'reds')
  call s:highlight('ModeMsg', 'lightorchid')
  call s:highlight('MoreMsg', 'riverblue')
  call s:highlight('Error', 'reds')

  " Lisp
  call s:highlight('lispMark', 'darkmagenta')
  syn match paren "[()]"
  hi def link paren Paren
  call s:highlight('Paren', 'darkred')
endfunction

" Set base colors.
if s:active_bg == 'dark'
  "call s:setDark()
else
  call s:setLight()
endif

