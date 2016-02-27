" Set pdf builder
setlocal makeprg=pandoc\ -fmarkdown\ --smart\ -o/tmp/%<.pdf\ %

" Create some handy shortcuts
nnoremap <F9> :Make!<CR>
nnoremap <F10> :!gnome-open /tmp/%<.pdf<CR>call feedkeys(" ")<CR>
