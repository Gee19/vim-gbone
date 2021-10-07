" vim-gbone - Simple wrapper for vim-tbone
" https://github.com/gee19/vim-gbone
" Author: Gee19 (https://github.com/Gee19)
" Version: 0.3

let s:last_known_repl_pane = ''
let s:last_indent_level = -1
let s:supports_line_numbers = ['mix test']
let s:supports_class_func = ['pytest -vvv']

function! gbone#send_to_repl(pane) abort
  if (a:pane == 'last' && s:last_known_repl_pane == '')
    echo 'No last REPL pane, use a direction first (hjkl)'
    return
  endif

  " Set pane to last_known_repl_pane if it exists, otherwise use supplied pane
  let l:pane = ''
  if (a:pane == 'last')
    let l:pane = s:last_known_repl_pane
  else
    let s:last_known_repl_pane = a:pane
    let l:pane = a:pane
  endif

  " Compare to previous indent level to close indented code
  let l:current_indent_level = indent(line('.'))
  if (s:last_indent_level > l:current_indent_level)
    execute 'Tmux send-keys -t '''.l:pane.''' ''C-u'''
  endif
  let s:last_indent_level = l:current_indent_level

  " Call Twrite then send Enter keypress
  execute 'Twrite '.l:pane.''
  execute 'Tmux send-keys -t '''.l:pane.''' ''Enter'''
endfunction

let s:last_known_test_pane = ''
function! gbone#send_to_pane(pane, cmd, clear, strategy) abort
  if (a:pane == 'last' && s:last_known_test_pane == '')
    echo 'No last test pane, use a direction first (hjkl)'
    return
  endif

  " Set pane to last_known_test_pane if it exists, otherwise use supplied pane
  let l:pane = ''
  if (a:pane == 'last')
    let l:pane = s:last_known_test_pane
  else
    let s:last_known_test_pane = a:pane
    let l:pane = a:pane
  endif

  execute 'Tmux send-keys -t '''.l:pane.''' ''C-u'''
  if (a:clear)
    execute 'Tmux send-keys -t '''.l:pane.''' ''clear'''
    execute 'Tmux send-keys -t '''.l:pane.''' ''Enter'''
  endif

  if (a:strategy == 'line')
    execute 'Tmux send-keys -t '''.l:pane.''' '''.a:cmd.' '' '.expand('%:p').':'.line('.')
  elseif (a:strategy == 'smart') && &runtimepath =~ 'current-func-info.vim'
    let s:class_func = substitute(cfi#format('%s', ''), "\\.", "::", "")
    if (s:class_func == '')
      execute 'Tmux send-keys -t '''.l:pane.''' '''.a:cmd.' '' '.expand('%:p')
    else
      execute 'Tmux send-keys -t '''.l:pane.''' '''.a:cmd.' '' '.expand('%:p').'::'.s:class_func
    endif
  else
    execute 'Tmux send-keys -t '''.l:pane.''' '''.a:cmd.' '' '.expand('%:p')
  endif

  execute 'Tmux send-keys -t '''.l:pane.''' ''Enter'''
endfunction
