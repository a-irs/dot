" meditation mode: disable linting

function! s:goyo_enter()
  set scrolloff=999
  CocDisable
  ALEDisable
  SignifyDisable

  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  set scrolloff=5
  CocEnable
  ALEEnable
  SignifyEnable

  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:goyo_width = '120'
let g:goyo_height = '100%'


nnoremap <silent> <leader>L :Goyo<CR>
nnoremap <silent> <leader>q :qall<CR>

