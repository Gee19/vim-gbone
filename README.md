# vim-gbone

Simple wrapper for [vim-tbone](https://github.com/tpope/vim-tbone).

Provides mappings for sending the current line to a TMUX pane in any direction, with smart indent level support. Automatically sends the `Enter` key after each line. Remembers the last two panes used for each function, until you restart vim.

I use it for the following:
- Language agnostic REPL
- Test runner
  - appends full buffer path by default plus some magic for running specific tests based on your cursor location:
    - current line number for elixir tests
    - `className::func_name` for python tests

## Installation

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'tpope/vim-tbone'
Plug 'Gee19/vim-gbone'
Plug 'Gee19/current-func-info.vim'
```

## Usage

```vim
if exists('$TMUX') && has_key(g:plugs, 'vim-tbone') && has_key(g:plugs, 'vim-gbone')
  " Language agnostic REPL
  " Creates 4 directional mappings as well (hjkl)
  let g:gbone_repl_mapping = '<silent> <leader>x'

  " Run commands based on filetype (appends full buffer path)
  let g:gbone_test_mapping = '<leader>t'
  let g:gbone_ft_map = { 'python': 'pytest -vvv', 'javascript': 'yarn test', 'elixir': 'mix test' }
endif
```

## TODO
- BUG: fix visual mode mapping sending full lines
- ENHANCEMENT: capture input for direction if last pane doesn't exist
- ENHANCEMENT (run specific tests):
  - allow configuration of appending line numbers/class names/function names
  - current-func-info should be optional

## Credit

- [tpope](https://github.com/tpope) for [vim-tbone](https://github.com/tpope/vim-tbone).
- [tyru](https://github.com/tyru) for [current-func-info](https://github.com/tyru/current-func-info.vim).
