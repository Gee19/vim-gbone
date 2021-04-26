" vim-gbone - Simple wrapper for vim-tbone
" https://github.com/gee19/vim-gbone
" Author: Gee19 (https://github.com/Gee19)
" Version: 0.1

if exists('g:loaded_gbone') && g:loaded_gbone
  finish
endif

noremap <silent><expr><Plug>(gbone-send-to-repl)    gbone#send_to_repl('last')
noremap <silent><expr><Plug>(gbone-send-to-repl-h)  gbone#send_to_repl('left')
noremap <silent><expr><Plug>(gbone-send-to-repl-j)  gbone#send_to_repl('bottom')
noremap <silent><expr><Plug>(gbone-send-to-repl-k)  gbone#send_to_repl('top')
noremap <silent><expr><Plug>(gbone-send-to-repl-l)  gbone#send_to_repl('right')

let g:loaded_gbone = 1
