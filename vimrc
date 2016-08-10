""" BASIC SETTINGS

set encoding=utf-8
scriptencoding utf-8

filetype plugin on
syntax enable
set autoindent  " use indent from current line when making new line
set backspace=indent,eol,start  " when at beginning of line, pressing backspace joins with prev line
set whichwrap+=<,>,[,]  " moves to next line when pressing right at end of line
set smarttab
set laststatus=2  " always show statusbar
set autoread  " auto reload file when unchanged in vim and changed outside vim
set history=2000
set scrolloff=2  " scrolling shows one line extra
set hlsearch  " highlight search results

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


""" PLUGINS

call plug#begin()

" UI plugins
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'

" syntax plugins
Plug 'gabrielelana/vim-markdown'
Plug 'pearofducks/ansible-vim'

" behavior plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'  " gc motion to toggle comments
Plug 'dahu/vim-fanfingtastic'  " f/t object wraps over lines
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'ervandew/supertab'  " enables TAB for snips autocomplete
Plug 'sirver/ultisnips'  " > 7.4 needed
Plug 'tpope/vim-endwise'  " auto-close if/func/...
Plug 'raimondi/delimitmate'  " auto-close brackets
Plug 'kien/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'wellle/targets.vim'  " add more text objects
Plug 'mhinz/vim-grepper'
Plug 'junegunn/goyo.vim'

call plug#end()


""" EXTENDED SETTINGS

" SPACE as leader key
nnoremap <SPACE> <Nop>
let mapleader="\<SPACE>"

" Goyo
nnoremap <leader>l :Goyo<CR>

" Goyo auto-close with :q
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction
function! s:goyo_leave()
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction
autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" Grepper
let g:grepper = {}
let g:grepper.highlight = 1
nnoremap <leader>g :Grepper<CR>
nnoremap <leader>G :Grepper -cword -noprompt<cr>

" UltraSnips
let g:UltiSnipsSnippetDirectories = ["snip"]
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Tabular split on first = or :
nmap <Leader>= :Tabularize /^[^=]*\zs=<CR>
vmap <Leader>= :Tabularize /^[^=]*\zs=<CR>
nmap <Leader>: :Tabularize /:\zs<CR>
vmap <Leader>: :Tabularize /:\zs<CR>
nmap <Leader>, :Tabularize /,\zs<CR>
vmap <Leader>, :Tabularize /,\zs<CR>

" CtrlP
let g:ctrlp_by_filename = 1
map <Leader>n :CtrlP<CR>
map <Leader>m :CtrlPMRU<CR>

" :w!! saves as sudo
cmap w!! w !sudo tee > /dev/null %

" single <leader> as easymotion key, e.g. <leader>w, <leader>e, ...
map <Leader> <Plug>(easymotion-prefix)

" disable highlighting search results
nnoremap <silent> <C-l> :nohl<CR><C-l>

" netrw
let g:netrw_liststyle=3  " tree style
let g:netrw_list_hide='.*\.swp$,\.DS_Store'
let g:netrw_sort_sequence='[\/]$'  " directories first
let g:netrw_sort_options='i'  " ignore case
let g:netrw_bufsettings = 'nomodifiable nomodified readonly nobuflisted nowrap'
map <C-_> :Lexplore<CR>

let g:markdown_enable_mappings = 0
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_input_abbreviations = 0

let g:airline_powerline_fonts = 1
let g:airline_section_z = '%l|%c'

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
set updatetime=500  " 500ms to update screen (e.g. gutter) instead of default 4000ms

set background=dark
colorscheme gruvbox

" show invisible chars
set list
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«
highlight SpecialKey ctermfg=grey
highlight NonText ctermfg=grey

" do not colorize background
highlight Normal ctermbg=none
highlight NonText ctermbg=none

" black background for columns>81
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn=join(range(81,999),",")
