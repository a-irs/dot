command PluginsUpdate
  \ PlugUpdate | PlugSnapshot! ~/.vim/conf.d/plug.snapshot

command PluginsLoad
  \ source ~/.vim/conf.d/plug.snapshot

call plug#begin()

Plug 'folke/which-key.nvim'
set timeoutlen=500

Plug 'preservim/nerdtree'
nnoremap <leader>t :NERDTreeToggle<CR>:wincmd p<CR>
Plug 'PhilRunninger/nerdtree-buffer-ops'

Plug 'tpope/vim-dispatch'
map <silent> <C-y> :Make<CR>
set errorformat=%m  " anything is shown in quickfix window instead of errors only

Plug 'tolecnal/icinga2-vim', { 'for': 'icinga2' }
autocmd BufNewFile,BufFilePre,BufRead */icinga/*/*.conf set filetype=icinga2

" filetypes pcre/pyre
Plug 'Galicarnax/vim-regex-syntax'

" filetype nix
Plug 'LnL7/vim-nix'

" filetype ps1
Plug 'PProvost/vim-ps1'

" disabled for now, to slow compared to builtin markdown ft
" let g:pandoc#syntax#conceal#use = g:markdown_syntax_conceal
" let g:pandoc#syntax#codeblocks#embeds#langs = g:markdown_fenced_languages
" autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
" Plug 'vim-pandoc/vim-pandoc-syntax'

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_conceal = g:markdown_syntax_conceal
let g:vim_markdown_conceal_code_blocks = g:markdown_syntax_conceal
let g:vim_markdown_fenced_languages = g:markdown_fenced_languages
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0

let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
" enable math syntax highlight, but disable concealing
let g:vim_markdown_math = 1
let g:tex_conceal = ''


Plug 'preservim/vim-markdown'

Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
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

" remember more history files (default: 100)
set viminfo=!,'300,h

Plug 'eiginn/iptables-vim', { 'for': 'iptables' }
autocmd BufNewFile,BufFilePre,BufRead *.rules set filetype=iptables

" better ft=sh, see https://www.reddit.com/r/vim/comments/c6supj/vimsh_better_syntax_highlighting_for_shell_scripts/
Plug 'arzg/vim-sh', { 'for': 'sh' }

" increase/decrease/toggle everything with ctrl+a/ctrl+x
Plug 'Konfekt/vim-CtrlXA'

Plug 'jaxbot/semantic-highlight.vim'
" curl -s https://docs.oracle.com/javase/tutorial/java/nutsandbolts/_keywords.html | grep '<td.*><code>' | sed -E "s|.*<code>(.+)</code>.*|\'\1\'|" | sort | tr '\n' ','
let g:semanticBlacklistOverride = {
	\ 'java': [
    \ 'abstract','assert','boolean','break','byte','case','catch','char','class','const','continue','default','do','double','else','enum','extends','final','finally','float','for','goto','if','implements','import','instanceof','int','interface','long','native','new','package','private','protected','public','return','short','static','strictfp','super','switch','synchronized','this','throw','throws','transient','try','void','volatile','while',
	\ 'Boolean', 'Double', 'Float', 'Char', 'Long', 'Int', 'Short', 'Byte', 'String',
	\ ],
    \ 'nim': [
    \ 'if', 'elif', 'else', 'for', 'while', 'in', 'proc', 'type', 'let', 'import', 'const', 'var', 'assert', 'string', 'int', 'seq', 'object', 'bool'
    \ ]
\ }
let g:semanticTermColors = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
let g:semanticEnableFileTypes = {'python': 'python', 'lua': 'lua', 'css': 'css', 'nim': 'nim', 'java': 'java', 'haskell': 'haskell', 'ruby': 'ruby', 'javascript': 'javascript'}
" re-highlight on save
augroup SemanticHL
    autocmd FileType python,lua,java,nim,haskell,ruby,javascript
        \ autocmd! SemanticHL BufWritePost <buffer> :SemanticHighlight
augroup END

" java
Plug 'uiiaoo/java-syntax.vim'
highlight link javaDelimiter NONE
highlight link javaIdentifier NONE

Plug 'chrisbra/Colorizer'
let g:colorizer_auto_filetype='css,html,conf,lua,sh,dosini'
let g:colorizer_colornames = 0  "do not colorize simple 'red', 'yellow', ...

Plug 'tpope/vim-commentary'
nmap <silent> <leader># :Commentary<CR>
vmap <silent> <leader># :Commentary<CR>
autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->
autocmd FileType nasm setlocal commentstring=;\ %s

" Plug 'airblade/vim-gitgutter'
" set background to same as SignColumn
" let g:gitgutter_set_sign_backgrounds = 1
" let g:gitgutter_map_keys = 0
" nmap <leader>< <Plug>(GitGutterNextHunk)
" nmap <leader>> <Plug>(GitGutterPrevHunk)

" git gutter
Plug 'mhinz/vim-signify'
let g:signify_sign_add = '+'
let g:signify_sign_delete = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change = '~'
let g:signify_sign_show_count = 0
let g:signify_sign_change_delete = g:signify_sign_change . g:signify_sign_delete_first_line
nmap <leader>< <plug>(signify-next-hunk)
nmap <leader>> <plug>(signify-prev-hunk)

" ALE async linter https://github.com/dense-analysis/ale/tree/master/ale_linters
Plug 'w0rp/ale'
" https://github.com/koalaman/shellcheck/wiki/SC2119
" https://github.com/koalaman/shellcheck/wiki/SC2029
let g:ale_sh_shellcheck_exclusions = 'SC2119,SC2029'
let g:ale_yaml_yamllint_options='-d "{extends: default, rules: {line-length: disable, document-start: disable}}"'
let g:ale_nasm_nasm_options='-f elf64'
let g:ale_python_flake8_options='--config ~/.config/flake8'
let g:ale_solidity_solc_options='--base-path / --include-path node_modules'

" disable some linters - done with coc
let g:ale_linters_ignore = ['hls', 'javac']
let g:ale_linters = {'python': []}

" ALE appearance  ▸▪
let g:ale_sign_warning = '▪'
let g:ale_sign_style_warning = '▪'
let g:ale_sign_error = '▪'
let g:ale_sign_style_error = '▪'
let g:ale_echo_msg_format = '[%linter%] %severity%% code%: %s'
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

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
let g:better_whitespace_ctermcolor = '1'
let g:better_whitespace_guicolor = '#ff6e67'
let g:strip_whitespace_confirm = 0
let g:strip_whitespace_on_save = 1
let g:strip_only_modified_lines = 1


" COC

if hostname() =~# 'srv.'
else
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-pyright',
    \ 'coc-yaml',
    \ 'coc-vimlsp',
    \ 'coc-snippets',
    \ 'coc-sh',
    \ 'coc-java',
    \ 'coc-tsserver',
    \ 'coc-word'
    \ ]

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

inoremap <silent> <C-p> <C-\><C-O>:call CocActionAsync('showSignatureHelp')<cr>
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
nmap <silent> K         :call <SID>show_documentation()<CR>
nmap <silent> <leader>k :call <SID>show_documentation()<CR>
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
let g:UltiSnipsSnippetDirectories = ['snip']

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

endif

Plug 'cespare/vim-toml', { 'for': 'toml' }

Plug 'hashivim/vim-terraform'

Plug 'mtdl9/vim-log-highlighting'

" ansible/jinja2
Plug 'pearofducks/ansible-vim'
let g:ansible_unindent_after_newline = 1
let g:ansible_extra_keywords_highlight = 1
let g:ansible_with_keywords_highlight = 'Constant'
let g:ansible_template_syntaxes = { '*.conf.j2': 'conf', '*.rules.j2': 'iptables', '*.xml.j2': 'xml', '*.sh.j2': 'sh', '*.yml.j2': 'yaml.ansible', '*.py.j2': 'python', '*.jcfg.j2': 'conf', '*.rb.j2': 'ruby', '*iptables/*': 'iptables' }
autocmd BufNewFile,BufFilePre,BufRead */playbooks/*.yml set filetype=yaml.ansible

" CSV filetype, for :Select queries see https://github.com/mechatroner/rainbow_csv#examples-of-rbql-queries
Plug 'mechatroner/rainbow_csv'

" verbose git commit message
Plug 'rhysd/committia.vim'
let g:committia_use_singlecolumn = 'always'

" highlight word under cursor
let g:Illuminate_useDeprecated = 1  " non-neovim compatiblilty
let g:Illuminate_delay = 100  " default: 0
let g:Illuminate_ftblacklist = ['gitcommit']
let g:Illuminate_ftHighlightGroups = {
      \ 'markdown:blacklist': ['markdownListMarker']
      \ }
Plug 'RRethy/vim-illuminate'

Plug 'zah/nim.vim'

" dark color schemes
Plug 'morhetz/gruvbox'
Plug 'sjl/badwolf'
Plug 'rhysd/vim-color-spring-night'
Plug 'sainnhe/gruvbox-material'
Plug 'NLKNguyen/papercolor-theme'

" light color schemes
Plug 'endel/vim-github-colorscheme'
Plug 'rakr/vim-colors-rakr'

call plug#end()

lua << EOF
require("which-key").setup {
}
EOF
