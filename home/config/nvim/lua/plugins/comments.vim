nmap <silent> <leader># :Commentary<CR>
vmap <silent> <leader># :Commentary<CR>
autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->
autocmd FileType nasm setlocal commentstring=;\ %s
autocmd FileType solidity setlocal commentstring=//\ %s
