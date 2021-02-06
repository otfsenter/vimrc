set nocompatible
set encoding=utf8
set guioptions-=T

set number
set guifont=consolas:h12
set backspace=indent,eol,start


let mapleader = ','
" set timeout
" set timeoutlen=150
" set ttimeoutlen=100

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

" fold
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



" F4 read tree in file
if g:iswindows
    noremap <F4> :e tree<cr>:%d<cr>:r !tree /F /A .<cr>:w!<CR>
    inoremap <F4> <esc>:e tree<cr>:%d<cr>:r !tree /F /A .<cr>:w!<CR>
endif





map <Enter> o<ESC>j
map <S-Enter> O<ESC>

" l: nohl
nnoremap <leader>l :nohlsearch<CR>


set spelllang=en_us,cjk
set spellcapcheck=


if g:iswindows
    set tags+=D:\code\vimrc\tags
else
    set tags+=~/code/tags
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'dense-analysis/ale'
" Plugin 'davidhalter/jedi-vim'
call vundle#end()


" for ALE plugin
let g:ale_linters = {'python': ['flake8', 'tsserver'], 'reStructuredText': ['rstcheck']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\}
let g:ale_fix_on_save = 1


" rr: run, run python script
if g:iswindows
    set makeprg=python\ %
else
    set makeprg=python3\ %
endif
" autocmd filetype python nmap <F5> :w!<CR>:!python %<CR>
autocmd filetype python nmap <leader>rr :w!<CR>:compiler python<CR>:make <bar> copen<CR>


" t, <space>, d, i: todo, todo list
nnoremap <leader>t i- [ ] <C-r>=strftime("(20%y-%m-%d %H:%M) ")<CR>
nnoremap <leader><space> mz^f[lci] <esc>`z
nnoremap <leader>d mz^f[lci]done<esc>`z
nnoremap <leader>i mz^f[lci]doing<esc>`z

" w, v: word, visual find word under cursor
nnoremap <leader>w viwy:vim /\V<C-R>"/ %<CR><CR>:cw<CR>
xnoremap <leader>v y:vim /\V<C-R>"/ %<CR><CR>:cw<CR>

" o: token
if g:iswindows
    nnoremap <leader>o :w!<CR>:e $doc/token.py<CR>:!python %<CR><CR>
endif

" c: copy image
if g:iswindows
    noremap <leader>c :r !python D:\code\vimrc\copy_img.py<CR>
else
    noremap <leader>c :r !python3 ~/code/vimrc/copy_img.py<CR>
endif

" p: plus
nnoremap <leader>p yiWA=<C-R>=<C-R>"<CR><ESC>

" e: error, find error is python file
autocmd filetype python nnoremap <leader>e :ALENext<CR>

" for quickfix
autocmd FileType qf nnoremap <buffer> <Enter> :.cc<CR><C-W>j
" autocmd FileType qf nnoremap <buffer> <Enter> :.cc<CR>


" windows jump

map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-k> <C-W>k
map <C-l> <C-W>l

" used letters
" l: nohl
" rr: run, run python script
" t, <space>, d, i: todo, todo list
" w, v: word, visual find word under cursor
" o: token
" c: copy image
" p: plus
" e: error, find error is python file

" unused letters
" bfghjkmnqsuxyz
