" vim-gbone - Simple wrapper for vim-tbone
" https://github.com/gee19/vim-gbone
" Author: Gee19 (https://github.com/Gee19)
" Version: 0.3

if exists('g:loaded_gbone') && g:loaded_gbone
  finish
endif

let s:quote_char = ''''
let s:visual_selection_thingy = ' :<C-u>' . s:quote_char . '<,' . s:quote_char . '>'

if exists('g:gbone_repl_mapping')
  execute 'nmap ' . g:gbone_repl_mapping . ' :call gbone#send_to_repl(''last'')<CR>'
  execute 'xnoremap ' . g:gbone_repl_mapping . s:visual_selection_thingy . 'call gbone#send_to_repl(''last'')<CR>'

  for [key, val] in items({'h':'left', 'j':'bottom', 'k':'top', 'l':'right'})
    execute 'nmap ' . g:gbone_repl_mapping . key . ' :call gbone#send_to_repl(' . s:quote_char . val . s:quote_char . ')<CR>'
    execute 'xnoremap ' . g:gbone_repl_mapping . key . s:visual_selection_thingy . 'call gbone#send_to_repl(' . s:quote_char . val . s:quote_char . ')<CR>'
  endfor
endif

if exists('g:gbone_ft_map') && exists('g:gbone_test_mapping')
  execute 'augroup long_live_tpope'
  execute 'autocmd!'
  for [ft, cmd] in items(g:gbone_ft_map)
    execute 'autocmd FileType ' . ft . ' nmap <buffer> ' . g:gbone_test_mapping . ' :call gbone#send_to_pane(''last'', ' . s:quote_char . cmd . s:quote_char . ', 1)<CR>'
    for [key, val] in items({'h':'left', 'j':'bottom', 'k':'top', 'l':'right'})
      execute 'autocmd FileType ' . ft . ' nmap <buffer> ' . g:gbone_test_mapping . key . ' :call gbone#send_to_pane(' . s:quote_char . val . s:quote_char . ', ' . s:quote_char . cmd . s:quote_char . ', 1)<CR>'
    endfor
  endfor
  execute 'augroup END'
endif

let g:loaded_gbone = 1
