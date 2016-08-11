""" BASIC SETTINGS

set encoding=utf-8
scriptencoding utf-8

filetype plugin on
syntax on
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

set updatetime=250

" show relative line numbers, except in current line
set number
set relativenumber

autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'yaml=ansible', 'jinja2=ansible_template', 'ini=dosini']
let g:markdown_syntax_conceal = 0
let g:markdown_enable_mappings = 0
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_input_abbreviations = 0

""" PLUGINS

call plug#begin()

" UI plugins
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/goyo.vim'

Plug 'sheerun/vim-polyglot'  " collection of syntax plugins
let g:polyglot_disabled = ['markdown']

" behavior plugins
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
" Plug 'dahu/vim-fanfingtastic'  " f/t object wraps over lines
" Plug 'easymotion/vim-easymotion'
" Plug 'tpope/vim-repeat'
Plug 'ervandew/supertab' | Plug 'sirver/ultisnips'
Plug 'tpope/vim-endwise'  " auto-close if/func/...
Plug 'raimondi/delimitmate'  " auto-close brackets
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
" Plug 'wellle/targets.vim'  " add more text objects
Plug 'mhinz/vim-grepper'
" Plug 'tpope/vim-fugitive'

call plug#end()


if (has("termguicolors"))
    set termguicolors
endif


""" EXTENDED SETTINGS

" SPACE as leader key
nnoremap <SPACE> <Nop>
let mapleader="\<SPACE>"

" buffer on <Leader>1-9
nnoremap <leader><left> :bprev<CR>
nnoremap <leader><right> :bnext<CR>
nnoremap <leader><up> :b#<CR>
nnoremap <leader>1 :buffer 1<CR>
nnoremap <leader>2 :buffer 2<CR>
nnoremap <leader>3 :buffer 3<CR>
nnoremap <leader>4 :buffer 4<CR>
nnoremap <leader>5 :buffer 5<CR>
nnoremap <leader>6 :buffer 6<CR>
nnoremap <leader>7 :buffer 7<CR>
nnoremap <leader>8 :buffer 8<CR>
nnoremap <leader>9 :buffer 9<CR>

" Signify
let g:signify_vcs_list = [ 'git' ]

" Goyo
nnoremap <leader>l :Goyo<CR>
let g:goyo_width = 80
let g:goyo_height = 100

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

" FZF
let g:fzf_files_options = '--preview "$HOME/.bin/preview {}"'
let g:fzf_buffers_jump = 1  " jump to existing if possible
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader><space> :Lines<CR>
nnoremap <silent> <leader>n :Files<CR>
nnoremap <silent> <leader>m :History<CR>
nnoremap <silent> <leader>o :Commits<CR>

" :w!! saves as sudo
cmap w!! w !sudo tee > /dev/null %

" stop highlighting search results
nnoremap <silent> <C-l> :nohl<CR><C-l>

" NERDCommenter
nnoremap # :call NERDComment(0,"toggle")<CR>
vnoremap # :call NERDComment(0,"toggle")<CR>
let g:NERDCommentEmptyLines = 1
let g:NERDRemoveExtraSpaces = 1
let g:NERDSpaceDelims = 1

" gitgutter
let g:gitgutter_map_keys = 0
nmap <Leader>< <Plug>GitGutterNextHunk
nmap <Leader>> <Plug>GitGutterPrevHunk

" netrw
let g:netrw_liststyle=3  " tree style
let g:netrw_list_hide='.*\.swp$,\.DS_Store'
let g:netrw_sort_sequence='[\/]$'  " directories first
let g:netrw_sort_options='i'  " ignore case
let g:netrw_bufsettings = 'nomodifiable nomodified readonly nobuflisted nowrap'
map <C-_> :Lexplore<CR>

" Airline
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_section_z = '%c'
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b' ],
    \ [ 'z', 'error', 'warning' ]
    \ ]
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2

" fallback color scheme
set background=dark
try
    colorscheme gruvbox
catch
    colorscheme peachpuff
endtry
set background=dark

" show invisible chars
set list
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«
highlight SpecialKey ctermfg=240
highlight NonText ctermfg=240

" do not colorize gutter
highlight clear SignColumn

" dark line numbers and tilde symbols after EOF
highlight LineNr ctermfg=240 guifg=#555555
highlight NonText ctermfg=240 guifg=#555555

