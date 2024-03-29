if exists('$TMUX')
    let g:fzf_layout = { 'tmux': '-d50%' }
else
    let g:fzf_layout = { 'down': '50%' }
endif
let g:fzf_buffers_jump = 1  " jump to existing if possible

" toggle preview window with ctrl + -/_
let g:fzf_preview_window = ['right:50%', 'ctrl-_']

" uses $FZF_DEFAULT_COMMAND
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader><Tab> :History<CR>
nnoremap <silent> <Leader>fg :GFiles<CR>
nnoremap <silent> <Leader>fm :GFiles?<CR>
nnoremap <silent> <Leader>s :Rg<CR>
