" vim: fdm=marker

"		 _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
" copyright: (c) 2015-2019 Gabriel Lima
" license: MIT

" CONTENTS:

" 1. Plugins ------------------------------------------------------------- {{{1

" 1.1. List -------------------------------------------------------------- {{{2

call plug#begin('~/.vim/plugged')

Plug 'flazz/vim-colorschemes'
Plug 'raimondi/delimitmate'
Plug 'sheerun/vim-polyglot'
Plug 'sirver/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'takac/vim-hardtime'
Plug 'wellle/targets.vim'
Plug 'w0rp/ale'
Plug 'vim-scripts/paredit.vim'
Plug 'junegunn/fzf.vim'

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Elixir
Plug 'slashmili/alchemist.vim'

" CSharp
Plug 'OmniSharp/omnisharp-vim'

call plug#end()

" 1.2. Settings ---------------------------------------------------------- {{{2

" ALE
let g:ale_sign_column_aways = 1
let g:ale_linters = {
			\'cs': ['OmniSharp']
			\}

" CtrlP
nnoremap gof :CtrlP<CR>
nnoremap gob :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = {
	\ 'dir': '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll|pyc|pyo|jar|zip|rar)$'
	\ }

" DelimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" Hardtime
let g:hardtime_default_on = 0
let g:hardtime_timeout = 2000
let g:hardtime_showmsg = 1

" YouCompleteMe
let g:ycm_show_diagnostics_ui = 0
let g:ycm_use_ultisnips_completer = 0

" OmniSharp
let g:OmniSharp_translate_cygwin_wsl = 1
let g:OmniSharp_highlight_types = 1
let g:OmniSharp_server_path = '/mnt/c/Omnisharp/omnisharp-roslyn/artifacts/publish/OmniSharp.Http.Driver/win7-x64/OmniSharp.exe'

" Polyglot
let g:polyglot_disabled = ['markdown']

" FZF
set rtp+=~/.fzf

" 2. Editor Preferences -------------------------------------------------- {{{1

" LEADER KEY
let mapleader = "\<SPACE>"

set encoding=utf-8
set nowrap
set backspace=indent,eol,start
set nobackup
set noswapfile
set mouse=a
set scrolloff=2
set spelllang=en_us
set visualbell
set modeline
set splitright
set shell=/bin/zsh
set clipboard=unnamedplus
set cm=blowfish2

" 2.1. Tab Preferences --------------------------------------------------- {{{2

set tabstop=4
set softtabstop=0
set expandtab
set smarttab
set shiftwidth=4
set autoindent
set shiftround
set copyindent
set completeopt=menu

" 2.2. Search Preferences ------------------------------------------------ {{{2

set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch

" Keep search matches in the middle of the screen
nnoremap n nzzzv
nnoremap N Nzzzv

" Don't move on *
nnoremap * *<C-O>


" 3. Appearance ---------------------------------------------------------- {{{1

set term=xterm
set t_Co=256
syntax on
colorscheme molokai
set t_ut=

" Show line numbers
set number
set relativenumber

" Show column #80
set colorcolumn=80

" Display '.' for trailing whitespace
set listchars=tab:→\ ,trail:·,eol:¬

" 3.1. Statusline -------------------------------------------------------- {{{2

set laststatus=2
set stl=[#%n]\ %F\ %=Row\ %l\ of\ %L;\ Column\ %v
hi StatusLine ctermbg=black ctermfg=white


" 4. Mappings ------------------------------------------------------------ {{{1

" 4.1. Normal Mode ------------------------------------------------------- {{{2

" Better way to get into command mode
nnoremap <CR> :

" Build/Test
nnoremap <F9> :Dispatch<CR>

" Window Resizing
nnoremap <silent>+ :vertical resize +5<CR>
nnoremap <silent>_ :vertical resize -5<CR>

" Move through wrapped lines
nnoremap j gj
nnoremap k gk

" REdo
nnoremap U <C-R>

" Maps '0' to BOL and '-' to EOL
nnoremap 0 ^
nnoremap - $

" Make Y behave like other capital letters
nnoremap Y y$

" Make ctrl-d pageup, ctrl-s pagedown
nnoremap <C-D> <C-B>
nnoremap <C-S> <C-F>

" Save file
nnoremap <LEADER>w :update<CR>

" Save file (sudo)
nnoremap <LEADER><LEADER>w :w !sudo tee % >/dev/null<CR>

" Quick quit
nnoremap <LEADER>q :bd<CR>

" Force quit
nnoremap <LEADER><LEADER>q :qa!<CR>

" Select last modified text
nnoremap gV `[v`]

" Global (Directory) Search
nnoremap <LEADER>a :Ack ""<LEFT>

" Documentation
nnoremap <F1> K

" Split line
nnoremap K i<CR><ESC>

" Make jumping more comfortable in ABNT2 keyboard
nnoremap ' `
nnoremap ` '

" Redraw!
nnoremap <F5> :redraw!<CR>

" Increment number
nnoremap <C-C> <C-A>

" Quick macro trigger
nnoremap Q @q

" Toggle Paste Mode
nnoremap <C-P> :set paste!<CR>

" 'Fix' jump list
nnoremap <C-O> <C-I>
nnoremap <C-I> <C-O>

" 'Fix' change list
nnoremap g, g;
nnoremap g; g,

" Navigate buffers
nnoremap <silent>gB :bprev<CR>
nnoremap <silent>gb :bnext<CR>

" Reindent whole file
nnoremap === gg=G
nnoremap =q= ggVGgq

" Open URL under cursor in browser (Make it compatible to gtfo e ctrlp)
nmap gox gx

" Evaluate current file (Clojure only)
nnoremap <LEADER>e :%Eval<CR>


" 4.2. Insert Mode ------------------------------------------------------- {{{2

" Better pasting in insert mode
inoremap <C-V> <C-R>+

" Navigate in insert mode
inoremap <C-J> <DOWN>
inoremap <C-K> <UP>
inoremap <C-B> <LEFT>
inoremap <C-L> <RIGHT>

" 4.3. Visual Mode ------------------------------------------------------- {{{2

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Maps '0' to BOL and '-' to EOL
vnoremap 0 ^
vnoremap - $

" Make ctrl-d pageup, ctrl-s pagedown
vnoremap <C-D> <C-B>
vnoremap <C-S> <C-F>

" Quit visual mode with 'space'
vnoremap <LEADER> <ESC>

" 4.4. Command Mode ------------------------------------------------------ {{{2

" Navigate history
cnoremap <C-J> <DOWN>
cnoremap <C-K> <UP>

" Add some nice search related shortcuts
cnoremap ¹ %
cnoremap ² s//
cnoremap ³ /g

" 5. Commands ------------------------------------------------------------ {{{1

" Tweak .vimrc
command! -nargs=0 Vimrc :tabe $MYVIMRC

" 'argdo' wrapper: substitute arglist with quickfix
" command! -nargs=0 -bar Qargs execute 'args' s:QuickfixFilenames()
command! -nargs=+ Argdo exe 'args' s:QuickfixFilenames() | argdo <args> | up


" 6. Autocommands -------------------------------------------------------- {{{1

" Remember last opened line
augroup RessurrectLine
	autocmd!
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\ exe "normal! g'\"" |
				\ endif
augroup END

" Source .vimrc when save
augroup VimReload
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Make default <CR> behavior for special cases
augroup DefaultCR
	autocmd!
	autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
	autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
augroup END

" Make text editing more pleasant
augroup TextEditing
	autocmd!
 	au FileType markdown,tex,rst setlocal textwidth=80 formatoptions+=ta
 	au FileType markdown,tex,rst :normal ggVGgq
augroup END

" Remove trailing whitespaces on save
augroup CleanFileOnSave
	autocmd!
	au BufWritePre * :call s:RemoveTrailingWhitespace()
augroup END

" Change status line color when entering insert mode
augroup StatusLineColor
	autocmd!
	au InsertLeave * hi StatusLine ctermbg=black ctermfg=white
	au InsertEnter * hi StatusLine ctermbg=214 ctermfg=black
augroup END

augroup Journaling
    autocmd!
    au BufNewFile,BufFilePre,BufRead *.jrnl set filetype=markdown
    au VimEnter *.jrnl $put=strftime('%n[%a, %d %b %Y %T %z]%n%n%n')
augroup END

" 7. Functions ----------------------------------------------------------- {{{1

" 'Fix' , and ;
function! s:InitConsistentRepeat(command)
	if a:command =~# '[FT]'
		noremap ; ,
		noremap , ;
	else
		silent! unmap ;
		silent! unmap ,
	endif
	return a:command
endfunc
noremap <expr> f <SID>InitConsistentRepeat('f')
noremap <expr> t <SID>InitConsistentRepeat('t')
noremap <expr> F <SID>InitConsistentRepeat('F')
noremap <expr> T <SID>InitConsistentRepeat('T')

" Build deduped quickfix file name list
function! s:QuickfixFilenames()
	let bufnrs = {}
	for item in getqflist()
		let bufnrs[item['bufnr']] = bufname(item['bufnr'])
	endfor
	return join(map(values(bufnrs), 'fnameescape(v:val)'))
endfunc

" Clean the file
function! s:RemoveTrailingWhitespace()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l,c)
endfunc

