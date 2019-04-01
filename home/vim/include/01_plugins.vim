call plug#begin()

Plug 'ervandew/supertab' | Plug 'sirver/ultisnips'
let g:UltiSnipsSnippetDirectories = ['snip']
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

Plug 'cespare/vim-toml'

Plug 'eiginn/iptables-vim'
autocmd BufNewFile,BufFilePre,BufRead *.rules set filetype=iptables

" auto-close brackets
Plug 'raimondi/delimitmate'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
let g:fzf_files_options = '--preview "$HOME/.bin/preview {}" --no-exact --color=16 --cycle --no-mouse'
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --no-ignore --follow --color always -E .vim/undo -E .vim/plugged -E .git -E __pycache__ -E Cache -E cache -E .gem -E .npm'
let g:fzf_buffers_jump = 1  " jump to existing if possible
nnoremap <silent> <leader>b :Buffers<CR>
" only useful with vim-fugitive
" nnoremap <silent> <leader>o :Commits<CR>
nnoremap <silent> _ :Files<CR>
nnoremap <silent> - :History<CR>

" TComment
Plug 'tomtom/tcomment_vim'
nnoremap <silent> <leader># :TComment<CR>
vnoremap <silent> <leader># :TComment<CR>

" gitgutter
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0
nmap <Leader>< <Plug>GitGutterNextHunk
nmap <Leader>> <Plug>GitGutterPrevHunk

" async linter
Plug 'w0rp/ale'
let g:ale_linters = { 'python': ['flake8', 'mypy'] }
" E501 = 80 characters
" W391 = blank line at end of file
" E129 = https://github.com/PyCQA/pycodestyle/issues/474
" E302 = expected 2 blank lines, found 1
let g:ale_python_flake8_options = '--ignore=E501,W391,E129,E302'
let g:ale_python_mypy_options = '--cache-dir /tmp/mypy'
let g:ale_sign_warning = "\u26A0"
let g:ale_sign_style_warning = "\u26A0"
let g:ale_sign_error = "\u2717"
let g:ale_sign_style_error = "\u2717"
let g:ale_echo_msg_format = '[%linter%] %severity%% code%: %s'
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
highlight ALEWarningSign guibg=NONE guifg=yellow
highlight ALEErrorSign guibg=NONE guifg=red

Plug 'davidoc/taskpaper.vim', { 'for': 'taskpaper' }
let g:task_paper_styles={ 'crit': 'guibg=#dd5010' }
augroup vimrc-taskpaper
    autocmd!
    autocmd FileType taskpaper call s:taskpaper_setup()
augroup END
" set toggle-task binding the same as toggle-comment
function! s:taskpaper_setup()
    nnoremap <silent> <buffer> <Leader>#
    \ :call taskpaper#toggle_tag('done', taskpaper#date())<CR>
endfunction

Plug 'ap/vim-buftabline'
set hidden
let g:buftabline_show = 1

" show trailing whitespace, except in current line
Plug 'ntpeters/vim-better-whitespace'

Plug 'vim-python/python-syntax'
let python_highlight_all = 1

Plug 'pearofducks/ansible-vim'
let g:ansible_unindent_after_newline = 1
let g:ansible_extra_keywords_highlight = 1
let g:ansible_with_keywords_highlight = 'Constant'
let g:ansible_template_syntaxes = { '*.conf.j2': 'conf', '*.rules.j2': 'iptables', '*.xml.j2': 'xml', '*.sh.j2': 'sh', '*.yml.j2': 'yaml.ansible', '*.py.j2': 'python' }
autocmd BufNewFile,BufFilePre,BufRead */playbooks/*.yml set filetype=yaml.ansible

" verbose git commit message
Plug 'rhysd/committia.vim'
let g:committia_use_singlecolumn = 'always'


" color schemes
Plug 'morhetz/gruvbox'
Plug 'sjl/badwolf'

call plug#end()


" auto-install missing plugins
augroup pluginstall
    autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif
augroup END