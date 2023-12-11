let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-pyright',
    \ 'coc-yaml',
    \ 'coc-vimlsp',
    \ 'coc-snippets',
    \ 'coc-sh',
    \ 'coc-java',
    \ 'coc-tsserver',
    \ 'coc-solidity',
    \ 'coc-word',
    \ 'coc-dictionary',
    \ 'coc-css',
    \ 'coc-diagnostic',
    \ '@yaegassy/coc-ansible',
    \ 'coc-ltex',
    \ ]
autocmd FileType scss setl iskeyword+=@-@
let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ 'tex': 'latex',
  \ }

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (index(['man'], &filetype) >= 0)
    execute ':Man ' . expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

inoremap <silent> <C-p> <C-\><C-O>:call CocActionAsync('showSignatureHelp')<cr>
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
nmap <silent> K         :call <SID>show_documentation()<CR>
nmap <silent> <leader>cr <Plug>(coc-rename)
xmap <silent> <leader>cf <Plug>(coc-format-selected)
nmap <silent> <leader>cf :call CocActionAsync('format')<CR>
nmap <silent> <leader>ca  <Plug>(coc-codeaction-cursor)
nmap <silent> <leader>cd  :<C-u>CocList diagnostics<cr>
nmap <silent> <leader>cs  <Plug>(coc-codeaction-source)

" Use <tab> and <S-tab> to navigate completion list:
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
" also use UltiSnips snippets
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1):
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
let g:coc_snippet_next = '<tab>'

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" <CR>: when a completion entry is selected, confirm selection. else, stop undo (see :h i_CTRL-g) and send return
inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "<C-g>u\<CR>"

" Map function and class text objects. NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> go :CocList outline<CR>
nmap <silent> gs :CocList symbols<CR>
nnoremap <silent><nowait> <leader>o  :call ToggleOutline()<CR>
function! ToggleOutline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline', 1)
  else
    call coc#window#close(winid)
  endif
endfunction
