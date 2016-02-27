" Set pdf builder
setlocal makeprg=pandoc\ -fmarkdown\ --smart\ -o/tmp/%<.pdf\ %

" Shortcut to open the generated pdf
nnoremap <F10> :!gnome-open /tmp/%<.pdf<CR>call feedkeys(" ")<CR>
