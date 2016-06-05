augroup MDFormat

augroup END

" Make editing text more pleasant
setlocal textwidth=80
setlocal formatoptions+=t
setlocal formatoptions+=a

" Set pdf builder
setlocal makeprg=pandoc\ -fmarkdown\ --smart\ -o/tmp/%<.pdf\ %

" Autoload
augroup GenerateMDOnSave
	au!
	au BufWritePost *.md,*.mkd,*.mkdw,*.markdown :Dispatch
augroup END

" Shortcut to open the generated pdf
nnoremap <F10> :!gnome-open /tmp/%<.pdf<CR>:call feedkeys(" ")<CR>:redraw!<CR>
