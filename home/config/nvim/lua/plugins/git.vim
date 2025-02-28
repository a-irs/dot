" signify
let g:signify_sign_add = '+'
let g:signify_sign_delete = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change = '~'
let g:signify_sign_show_count = 0
let g:signify_sign_change_delete = g:signify_sign_change . g:signify_sign_delete_first_line
nmap <leader>< <plug>(signify-next-hunk)
nmap <leader>> <plug>(signify-prev-hunk)

" committia
let g:committia_use_singlecolumn = 'always'

" only use for staging hunk mapping
let g:gitgutter_map_keys = 0
let g:gitgutter_signs = 0
nmap <silent> <Leader>gs <Plug>(GitGutterStageHunk)
