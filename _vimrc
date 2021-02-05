set nocompatible
set encoding=utf8
set guioptions-=T

set number
set guifont=consolas:h12

autocmd TextChanged,TextChangedI *.rst,*.txt,*.py silent write

let g:iswindows = 0
let g:islinux = 0
if (has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif


if has("gui_running")
    let g:isgui = 1
else
    let g:isgui = 0
endif

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
" set foldmethod=manual
set foldmethod=indent
set foldnestmax=1
autocmd FileType rst set foldmethod=indent
autocmd FileType rst set foldnestmax=1
nnoremap <space> za
vnoremap <space> zf



set langmenu=en_US
let $LANG = 'en_US'

set scrolloff=5
set wildmenu


if g:islinux
    function HeaderPython()
        call setline(1, "#!/usr/bin/env python3")
        call setline(2, "# -*- coding: utf-8 -*-")
        call setline(3, "# author: otfsenter")
        normal G
        normal o
    endf
    autocmd bufnewfile *.py call HeaderPython()
endif

if g:iswindows
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
endif


" set path to find file
if g:iswindows
    set path+=D:/note/pydict/source/**
endif

" todo list
inoremap <m-m> - [ ] <c-r>=strftime("(20%y-%m-%d %H:%M) ")<cr>
map <leader><space> ^f[l<ESC>ci] <esc>
map <leader>d ^f[l<ESC>ci]done<esc>
map <leader>i ^f[l<ESC>ci]doing<esc>


" F4 read tree in file
if g:iswindows
    noremap <F4> :e tree<cr>:%d<cr>:r !tree /F /A .<cr>:w!<CR>
    inoremap <F4> <esc>:e tree<cr>:%d<cr>:r !tree /F /A .<cr>:w!<CR>
endif

" F5 run python scripts

if g:iswindows
    set makeprg=python\ %
else
    set makeprg=python3\ %
endif

" autocmd filetype python nmap <F5> :w!<CR>:!python %<CR>
if g:iswindows
    autocmd filetype python nmap <m-r> :w!<CR>:compiler python<CR>:make <bar> copen<CR>
    autocmd filetype python imap <m-r> :w!<CR>:compiler python<CR>:make <bar> copen<CR>
    autocmd filetype java nnoremap <m-r> :!javac %<CR> :!java %:r<CR>
else
    autocmd filetype python nmap ® :w!<CR>:compiler python<CR>:make <bar> copen<CR>
    autocmd filetype python imap ® :w!<CR>:compiler python<CR>:make <bar> copen<CR>
    autocmd filetype java nnoremap ® :!javac %<CR> :!java %:r<CR>
endif

inoremap <m-p> <ESC>yiWA=<C-R>=<C-R>"<CR><ESC>

if g:iswindows
    nnoremap <m-o> :w!<CR>:e $doc/token.py<CR>:!python %<CR><CR>
    noremap <m-i> :r !python D:\code\vimrc\copy_img.py<CR>
else
    noremap <m-i> :r !python3 ~/code/vimrc/copy_img.py<CR>
endif

if g:iswindows
    noremap <m-c> viwy:vim /<C-R>"/ %<CR><CR>:cw<CR>
else
    noremap ç viwy:vim /<C-R>"/ %<CR><CR>:cw<CR>
endif

map <Enter> o<ESC>j
map <S-Enter> O<ESC>

nnoremap <C-l> :nohlsearch<CR>


set spelllang=en_us,cjk
set spellcapcheck=


autocmd FileType qf nnoremap <buffer> <Enter> :.cc<CR><C-W>j
" autocmd FileType qf nnoremap <buffer> <Enter> :.cc<CR>

if g:iswindows
    set tags+=D:\code\vimrc\tags
endif



" filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'dense-analysis/ale'

" Plugin 'davidhalter/jedi-vim'


call vundle#end()


let g:ale_linters = {'python': ['flake8', 'tsserver'], 'reStructuredText': ['rstcheck']}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\}

let g:ale_fix_on_save = 1

nnoremap <F2> :ALENext<CR>
