" vim: fdm=marker

"             _
"  _ ____   _(_)_ __ ___
" | '_ \ \ / / | '_ ` _ \
" | | | \ V /| | | | | | |
" |_| |_|\_/ |_|_| |_| |_|
"
"

" copyright: (c) 2015-2016 Gabriel Lima
" license: MIT

" CONTENTS:

" 1. Plugins ------------------------------------------------------------- {{{1

" 1.1. List -------------------------------------------------------------- {{{2

call plug#begin('~/.nvim/plugged')

Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'
Plug 'neomake/neomake'
Plug 'raimondi/delimitmate'
Plug 'sheerun/vim-polyglot'
Plug 'sirver/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'kien/ctrlp.vim'

let g:plug_url_format = 'git@github.com:%s.git'
Plug 'ewilazarus/vim-snippets'
unlet g:plug_url_format

function! DoRemote(arg)
	UpdateRemotePlugins
endfunction
Plug 'shougo/deoplete.nvim', { 'do': function('DoRemote') }

call plug#end()

" 1.2. Settings ---------------------------------------------------------- {{{2

" CtrlP
nnoremap go. :CtrlP<CR>
nnoremap gob :CtrlPBuffer<CR>
nnoremap goh :CtrlP /home/ewilazarus<CR>
nnoremap gow :CtrlP /home/ewilazarus/Workspace<CR>
nnoremap god :CtrlP /home/ewilazarus/Dropbox<CR>
nnoremap gou :CtrlP /home/ewilazarus/UniFB<CR>
nnoremap gos :CtrlP /home/ewilazarus/.vim/plugged/vim-snippets/UltiSnips<CR>
nnoremap go? :echo "[.] Current; [b] Buffers; [h] Home; [w] Workspace; [d] Dropbox; [u] UniFB; [s] Snippets"<CR>
let g:ctrlp_custom_ignore = {
			\ 'dir': '\v[\/](node_modules|\.(git|hg|svn))$',
			\ 'file': '\v\.(exe|so|dll|pyc|pyo|jar|zip|rar)$'
			\ }

" DelimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" Deoplete
let g:deoplete#enable_at_startup = 1

" Neomake
let g:neomake_javacripts_enabled_makers = ['jshint']

" Netrw
let g:netrw_localrmdir='rm -rf'


" 2. Preferences --------------------------------------------------------- {{{1

" 2.1. OS Integration ---------------------------------------------------- {{{2

set nobackup
set noswapfile
set clipboard=unnamedplus
set shell=/bin/bash

" 2.2. Behavior ---------------------------------------------------------- {{{2

set modeline
set spelllang=en_us
set encoding=utf-8

" 2.3. UX ---------------------------------------------------------------- {{{2

set scrolloff=2
set visualbell
set splitright

" 2.4. Text -------------------------------------------------------------- {{{2

set nowrap

" 2.5. Tabs -------------------------------------------------------------- {{{2

set tabstop=4
set smarttab
set shiftwidth=4
set autoindent
set shiftround
set copyindent
set completeopt=menu

" 2.6. Search ------------------------------------------------------------ {{{2

set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch


" 3. Appearence ---------------------------------------------------------- {{{1

" Colorscheme
colorscheme molokai

" Show line numbers
set number
set relativenumber

" Show column #80
set colorcolumn=80

" 'Invisible' character representation
set listchars=tab:→\ ,trail:·,eol:¬


" 4. Leader Key ---------------------------------------------------------- {{{1

let mapleader = "\<SPACE>"


" 5. Mappings ------------------------------------------------------------ {{{1

" 5.1. NORMAL ------------------------------------------------------------ {{{2

" Move inbetween panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move through wrapped lines
nnoremap j gj
nnoremap k gk

" REdo
nnoremap U <C-r>

" Go to BOL and EOL
nnoremap H ^
nnoremap L $

" Select last modified text
nnoremap gV `[v`]

" Documentation
nnoremap <F1> K

" Split line
nnoremap K i<CR><ESC>

" Better jumping in ABNT2 Keyboard
nnoremap ' `
nnoremap ` '

" Redraw screen
nnoremap <F5> :redraw!<CR>

" Quick macro trigger
nnoremap Q @q

" Toggle paste mode
nnoremap cop :set paste!<CR>

" Navigate buffers
nnoremap <silent>gB :bprev<CR>
nnoremap <silent>gb :bnext<CR>

" Reindent whole file
nnoremap === gg=G

" Make Y behave like other capital letters
nnoremap Y y$

" Keep search matches in the middle of the screen
nnoremap n nzzzv
nnoremap N Nzzzv

" Don't move on '*'
nnoremap * *<C-O>

" Quicker save
nnoremap <LEADER>w :update<CR>

" Quicker quit
nnoremap <LEADER>q :q<CR>

" 5.2. INSERT ------------------------------------------------------------ {{{2

" Better pasting in insert mode
inoremap <C-V> <C-R>+

" Move cursor to the right
inoremap <C-L> <RIGHT>

" 5.4. VISUAL ------------------------------------------------------------ {{{2

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Go to BOL and EOL
vnoremap H ^
vnoremap L $

" 5.5. COMMAND ----------------------------------------------------------- {{{2

" EMPTY


" 6. Commands ------------------------------------------------------------ {{{1

" Tweak .nvimrc
command! -nargs=0 Vimrc :tabe $MYNVIMRC


" 7. Autocommands -------------------------------------------------------- {{{1

" Remember last opened line
augroup RessurrectLine
	autocmd!
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\ exe "normal! g'\"" |
				\ endif
augroup END

" Source .nvimrc on save
augroup VimReload
	autocmd!
	autocmd BufWritePost $MYNVIMRC source $MYNVIMRC
augroup END

" Remove trailing whitespaces on save
augroup CleanFileOnSave
	autocmd!
	au BufWritePre * :call s:RemoveTrailingWhitespace()
augroup END


" 8. Functions ----------------------------------------------------------- {{{1

" Remove white spaces
function! s:RemoveTrailingWhitespace()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l,c)
endfunc
