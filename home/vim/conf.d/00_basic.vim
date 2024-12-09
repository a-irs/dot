set encoding=utf-8
scriptencoding utf-8

" disable NVIM providers except python
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

filetype plugin on
syntax on
set backspace=indent,eol,start  " when at beginning of line, pressing backspace joins with prev line
set whichwrap+=<,>,[,]  " moves to next line when pressing right at end of line
set linebreak  " wrap lines at words
set smarttab
set autoread  " auto reload file when unchanged in vim and changed outside vim
set history=2000  " command history
set scrolloff=5  " scrolling shows extra lines
set hlsearch  " highlight search results
set incsearch  " search during input
set fillchars+=vert:│  " prettier split separator

" When switching buffers, preserve window view.
au BufLeave * if !&diff | let b:winview = winsaveview() | endif
au BufEnter * if exists('b:winview') && !&diff | call winrestview(b:winview) | endif

" remember more history files (default: 100)
set viminfo=!,'300,h

" ignore temp/removable paths for viminfo/history etc.
set viminfo+=r/tmp,r/run/user,r/mnt

" disable swap file completely:
" - on concurrent writes, VIM warns accordingly anyway (and undo file helps as well)
" - backup is not needed as :w is used often enough
" - does not clutter file system, ...
set noswapfile

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" line wrap indicator
set breakindent
set showbreak=»\  " trailing space

set updatetime=150

" statusbar
set laststatus=0  " never show statusbar
set statusline=
set statusline+=%F  " show full file path
set statusline+=\ [%l:%v]  " show line number / position
set statusline+=\ %m%r%h%w  " show when file is modified
set statusline+=%=  " right-align from now on
set statusline+=%{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %{&ff}
set statusline+=\ %{&bomb?'BOM':''}

" show e.g. "[2/16]" for search results
set shortmess-=S

" no delay on entering normal mode
set ttimeoutlen=0

" set cursor
let &t_SI = "\<Esc>[6 q"  " insert mode: ibeam
let &t_SR = "\<Esc>[4 q"  " replace mode: underline
let &t_EI = "\<Esc>[2 q"  " normal mode: block

" gvim
set guifont=Input\ Mono\ Condensed:h9
set guioptions-=m  " remove menu bar
set guioptions-=T  " remove toolbar
set guioptions-=r  " remove right scroll bar
set guioptions-=L  " remove left scroll bar

" disable register/yank limits
set viminfo-=<50,s10

" persistent undo
set undofile
set undodir=~/.vim/undo/vim
if has('nvim')
    set undodir=~/.vim/undo/nvim
endif
silent call system('mkdir -p ' . &undodir)

" make system clipboard and VIM default register the same
" set clipboard^=unnamed,unnamedplus

" disable yank for single-char delete
noremap x "_x

" jump to last position on VIM start
augroup lastposition
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
augroup END

" move through wrapped lines
inoremap <silent> <Down> <C-o>gj
inoremap <silent> <Up> <C-o>gk
nnoremap <silent> <Down> gj
nnoremap <silent> <Up> gk

" disable mouse in neovim
if has('nvim')
    set mouse-=a
endif

" netrw
let g:netrw_liststyle=3  " tree style
let g:netrw_list_hide='.*\.swp$,\.DS_Store'
let g:netrw_sort_sequence='[\/]$'  " directories first
let g:netrw_sort_options='i'  " ignore case
let g:netrw_bufsettings = 'nomodifiable nomodified readonly nobuflisted nowrap'
let g:netrw_browse_split=4  " open files in previous window
let g:netrw_banner=0  " hide header
let g:netrw_winsize=25  " 25% width
let g:netrw_altv=1  " show on left side

autocmd BufNewFile,BufFilePre,BufRead Jenkinsfile set filetype=groovy
autocmd BufNewFile,BufFilePre,BufRead Dockerfile* set filetype=dockerfile
autocmd BufNewFile,BufFilePre,BufRead dircolors* set filetype=dircolors
autocmd BufNewFile,BufFilePre,BufRead */.dot/setup.conf set filetype=dosini
autocmd BufNewFile,BufFilePre,BufRead *.asm set filetype=nasm
autocmd BufNewFile,BufFilePre,BufRead vifmrc set filetype=vim
autocmd BufNewFile,BufFilePre,BufRead *.vifm set filetype=vim
autocmd BufNewFile,BufFilePre,BufRead *.json5 set filetype=jsonc

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType go setlocal noet ts=4 sw=4 sts=4

" do not auto-hardwrap git commit messages
autocmd Filetype gitcommit setlocal formatoptions-=t

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'sh', 'shell=sh', 'ini=dosini', 'ocaml', 'rust', 'css', 'erb=eruby', 'ruby', 'c', 'cpp', 'dockerfile', 'js=javascript', 'yaml', 'jinja2', 'sql', 'ps1', 'config', 'asm', 'json', 'patch=diff', 'diff', 'go', 'nim', 'log', 'haskell', 'sol=solidity', 'splunk=spl']
let g:markdown_syntax_conceal = 0
let g:markdown_enable_mappings = 0
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_input_abbreviations = 0

" match parantheses etc. with % key
runtime macros/matchit.vim

" SPACE as leader key
nnoremap <SPACE> <Nop>
let g:mapleader="\<SPACE>"

" :w!! saves as sudo
cmap w!! w !sudo tee > /dev/null %

" stop highlighting search results
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" toggle line numbers
nnoremap <silent> <leader>wn :set number!<CR>

" toggle line wrap
nnoremap <silent> <leader>ww :set wrap!<CR>

" buffer on <Leader>1-9/tab
nnoremap <silent> <leader><right> :bnext<CR>
nnoremap <silent> <leader><left> :bprev<CR>
nnoremap <silent> <leader>1 :buffer 1<CR>
nnoremap <silent> <leader>2 :buffer 2<CR>
nnoremap <silent> <leader>3 :buffer 3<CR>
nnoremap <silent> <leader>4 :buffer 4<CR>
nnoremap <silent> <leader>5 :buffer 5<CR>
nnoremap <silent> <leader>6 :buffer 6<CR>
nnoremap <silent> <leader>7 :buffer 7<CR>
nnoremap <silent> <leader>8 :buffer 8<CR>
nnoremap <silent> <leader>9 :buffer 9<CR>

noremap <silent> <Leader>x :bd<CR>
noremap <silent> <Leader>X :tabc<CR>

" yank to system clipboard
noremap <silent> <Leader>y "+y

" surround with quotes/brackets
nnoremap <leader>*         viw<esc>a*<esc>hbi*<esc>lel
nnoremap <leader><leader>* viW<esc>a*<esc>hBi*<esc>lel
nnoremap <leader>'         viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader><leader>' viW<esc>a'<esc>hBi'<esc>lel
nnoremap <leader>"         viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader><leader>" viW<esc>a"<esc>hBi"<esc>lel
nnoremap <leader>(         viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>)         viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader><leader>( viW<esc>a)<esc>hBi(<esc>lel
nnoremap <leader><leader>) viW<esc>a)<esc>hBi(<esc>lel
nnoremap <leader>[         viw<esc>a]<esc>hbi[<esc>lel
nnoremap <leader>]         viw<esc>a]<esc>hbi[<esc>lel
nnoremap <leader><leader>[ viW<esc>a]<esc>hBi[<esc>lel
nnoremap <leader><leader>] viW<esc>a]<esc>hBi[<esc>lel
nnoremap <leader>{         viw<esc>a}<esc>hbi{<esc>lel
nnoremap <leader>}         viw<esc>a}<esc>hbi{<esc>lel
nnoremap <leader><leader>{ viW<esc>a}<esc>hBi{<esc>lel
nnoremap <leader><leader>} viW<esc>a}<esc>hBi{<esc>lel
nnoremap <leader>t         viW<esc>a><esc>hBi<<esc>lel

" move lines up/down
vnoremap <silent> <leader><Down> :m '>+1<CR>gv=gv
vnoremap <silent> <leader><Up> :m '<-2<CR>gv=gv
nnoremap <silent> <leader><Down> :m .+1<CR>==
nnoremap <silent> <leader><Up> :m .-2<CR>==

" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ''
endfunction


" MAN PAGES
let g:no_man_maps = 1

" inspired by https://github.com/jez/vim-superman
function! SuperMan(...)
  if exists(":Man") != 2 " No :Man command defined
    source $VIMRUNTIME/ftplugin/man.vim
  endif

  " Build and pass off arguments to Man command
  execute 'Man' join(a:000, ' ')

  " Quit with error code if there is only one line in the buffer (i.e., manpage not found)
  if line('$') == 1 | cquit | endif

  bw 1
  silent only

  " Set options appropriate for viewing manpages
  setlocal readonly
  setlocal nomodifiable
  setlocal noswapfile

  setlocal noexpandtab
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal shiftwidth=4
  setlocal nolist
  set showbreak=
  if exists('+colorcolumn')
    setlocal colorcolumn=0
  endif

  noremap q :q!<CR>

  " from /usr/share/nvim/runtime/ftplugin/man.vim
  nnoremap <silent> gO :lua require'man'.show_toc()<CR>
  nnoremap <silent> <2-LeftMouse> :Man<CR>
  nmap <silent> <CR>:call show_documentation()<CR>
endfunction

command! -nargs=+ SuperMan call SuperMan(<f-args>)
