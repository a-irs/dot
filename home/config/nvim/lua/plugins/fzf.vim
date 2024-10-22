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
nnoremap <silent> <Leader>f<Tab> :History<CR>
nnoremap <silent> <Leader>fg :GFiles<CR>
nnoremap <silent> <Leader>fm :GFiles?<CR>
nnoremap <silent> <Leader>fs :Rg<CR>
nnoremap <silent> <Leader>fb :Lines<CR>

" fugitive + fzf
nnoremap <silent> <Leader>gc :BCommits<CR>

" fugitive
nnoremap <silent> <Leader>gb :Git blame<CR>
nnoremap <silent> <Leader>gg :tab Git<CR>
nnoremap <silent> <Leader>gl :tab Git log<CR>
autocmd FileType fugitive nmap <buffer> <Tab> =

" default to verbose commits (show diff under commit message)
autocmd FileType fugitive nmap <buffer> cc cvc
autocmd FileType fugitive nmap <buffer> ca cva
autocmd FileType fugitive nnoremap <buffer> <silent> c :<C-U>Gcommit --verbose<CR><C-w>_O<Esc>

" remove 'reword' binding to not trigger it accidentially...
autocmd FileType fugitive nmap <buffer> cw <Nop>

" do not auto-close fugitive buffers
autocmd User FugitiveObject setlocal bufhidden=
