# vim-gbone

Small, extensible wrapper around [vim-tbone](https://github.com/tpope/vim-tbone).

Transform vim + tmux into a fully customizable test runner, language agnostic REPL, or whatever your heart desires.

Does NOT replace `vim-tbone`, `vim-dispatch`, `AsyncRun.vim` or `vim-test`.

## Installation

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'tpope/vim-tbone'
Plug 'Gee19/vim-gbone'
Plug 'tyru/current-func-info.vim' " Optional
```

### Run Usage
- Send pre-defined run command to a tmux pane in *any direction*
- Appends full buffer path

### REPL Usage
- Sends the current line (or visually selected lines) to a tmux pane in *any direction*, with *smart indent level support*.
- Automatically sends the `Enter` key after each line.

### Test Runner Usage
- Sends your pre-defined test command to a tmux pane in *any direction*.
- Appends the full buffer path.
- Optionally, appends the current line number, class or class & function.

|    Strategy | Description                                                    | Example                                        |
| :---------- | :--------------------------------------------------------------| :--------------------------------------------- |
| **smart**   | Test specific func, class or file depending on cursor location | `pytest /path/to/file{::className}{::funcName}`|
| **line**    | Append line number to test command                             | `mix test /path/to/file.exs:12`                |

Note:
- *Remembers the last two panes used for each function, until you restart vim.*
- `smart` strategy *requires* `current-func-info.vim`.
- Supports: `C, Go, Perl, PHP, Python, Ruby, VimL, PL/SQL, sh, Bash, Zsh, Elixir`

## Configuration

```vim
  let g:gbone_run_mapping = '<leader>x'
  let g:gbone_run_ft_map = {
  \ 'python': 'python3.8',
  \ 'javascript': 'node',
  \ }

  let g:gbone_repl_mapping = '<leader>rl'
  let g:gbone_test_mapping = '<leader>t'

  let g:gbone_ft_map = {
  \ 'python': 'pytest -vvv',
  \ 'javascript': 'yarn test',
  \ 'elixir': 'mix test',
  \ 'spec': 'npx cypress run --browser firefox --spec'
  \ }

  let g:gbone_ft_strategy = {
  \ 'python': 'smart',
  \ 'elixir': 'line',
  \ }
```

## TODO
- BUG: fix visual mode mapping sending full lines?
- ENHANCEMENT: capture input for direction if last pane doesn't exist
- localleader might be the move
- write help text

## Credit

- [tpope](https://github.com/tpope) for [vim-tbone](https://github.com/tpope/vim-tbone).
- [tyru](https://github.com/tyru) for [current-func-info](https://github.com/tyru/current-func-info.vim).
