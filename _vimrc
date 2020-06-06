set nocompatible
set encoding=utf8
set guioptions-=T

set number
set guifont=consolas:h12

syntax on

filetype plugin indent on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

set nobackup
set noswapfile
set nowritebackup

set ignorecase
set smartcase

"set cursorline
set foldmethod=manual

set langmenu=en_US
let $LANG = 'en_US'

set scrolloff=5
set wildmenu

autocmd filetype py nmap <F5> :w!<CR>:!python %<CR>
autocmd filetype java nnoremap <F5> :w!<CR> :!javac %<CR> :!java %:r<CR>

function HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call setline(2, "# -*- coding: utf-8 -*-")
    call setline(3, "# author: otfsenter")
    normal G
    normal o
endf
autocmd bufnewfile *.py call HeaderPython()

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" insert time
iab mn <c-r>=strftime("(20%y-%m-%d %H:%M)")<cr>

" set path to find file
set path+=D:/note/pydict/source/**

" todo list
inoremap mt - [ ] 
map <leader>t ^f[l<ESC>ci] <esc>:w!<cr>
map <leader>d ^f[l<ESC>ci]done<esc>:w!<cr>
map <leader>i ^f[l<ESC>ci]doing<esc>:w!<cr>

" read tree in file
map <F6> :%d<cr>:r !tree /F /A .<cr>:w!<cr>

inoremap { {<cr>}<esc>O

" add num
inoremap <F7> <ESC>yiWA=<C-R>=<C-R>"<CR><ESC>:w!<CR>

map <Enter> o<ESC>j
map <S-Enter> O<ESC>
