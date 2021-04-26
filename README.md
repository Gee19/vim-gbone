# vim-gbone

Simple wrapper for [vim-tbone](https://github.com/tpope/vim-tbone).

Provides mappings for sending the current line to a TMUX pane in any direction, with smart indent level support. Automatically sends the `Enter` key after each line. Remembers the last two panes used for each function, until you restart vim.

I use it for the following:
- Language agnostic REPL
- Test runner (appends full buffer path)

## Installation

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'tpope/vim-tbone'
Plug 'Gee19/vim-gbone'
```

## Usage

```vim
if exists('$TMUX') && has_key(g:plugs, 'vim-tbone') && has_key(g:plugs, 'vim-gbone')
  " Language agnostic REPL
  nmap <silent> <leader>x <Plug>(gbone-send-to-repl)
  nmap <silent> <leader>xh <Plug>(gbone-send-to-repl-h)
  nmap <silent> <leader>xj <Plug>(gbone-send-to-repl-j)
  nmap <silent> <leader>xk <Plug>(gbone-send-to-repl-k)
  nmap <silent> <leader>xl <Plug>(gbone-send-to-repl-l)

  " pytest runner for python files
  augroup long_live_tpope
    autocmd!
    autocmd FileType python nmap <buffer> <leader>t :call gbone#send_to_pane('last', 'pytest -vv', 1)<CR>
    autocmd FileType python nmap <buffer> <leader>th :call gbone#send_to_pane('left', 'pytest -vv', 1)<CR>
    autocmd FileType python nmap <buffer> <leader>tj :call gbone#send_to_pane('bottom', 'pytest -vv', 1)<CR>
    autocmd FileType python nmap <buffer> <leader>tk :call gbone#send_to_pane('top', 'pytest -vv', 1)<CR>
    autocmd FileType python nmap <buffer> <leader>tl :call gbone#send_to_pane('right', 'pytest -vv', 1)<CR>
  augroup END
endif
```

## TODO

- 1 keymap for test current buffer, 1 keymap for send line to pane
- capture input for direction if last pane doesn't exist
- define test commands mapping for filetype, or auto determine if possible
- `let g:gbone_ft_map = {'python': 'pytest -vv', 'javascript': 'yarn test'}`

## Credit

- [tpope](https://github.com/tpope) for [vim-tbone](https://github.com/tpope/vim-tbone).
