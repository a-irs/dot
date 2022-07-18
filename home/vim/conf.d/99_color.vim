if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set t_Co=256
    set termguicolors
endif

augroup my_highlight
    autocmd!

    " clear backgrounds (git gutter, line numbers, ...)
    autocmd ColorScheme * highlight SignColumn guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight SignifySignAdd guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight SignifySignChange guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight SignifySignDelete guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight LineNr guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight FoldColumn guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight Folded guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight ALEError guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight ALEErrorSign guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight ALEWarningSign guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight ALEInfoSign guibg=NONE ctermbg=NONE

    autocmd ColorScheme * highlight CursorLineNr guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight! link CursorLineNr LineNr

    " show invisible chars
    autocmd ColorScheme * set list
    autocmd ColorScheme * set listchars=tab:▸\ ,extends:»,precedes:«
    autocmd ColorScheme * highlight! link NonText LineNr
    autocmd ColorScheme * highlight! link SpecialKey LineNr

    " folding
    autocmd ColorScheme * highlight FoldColumn guifg=#8888aa
    autocmd ColorScheme * highlight Folded cterm=bold gui=bold guibg=#3a4b5c

    autocmd ColorScheme * highlight clear ALEError
    autocmd ColorScheme * highlight clear ALEWarning
    autocmd ColorScheme * highlight clear ALEInfo
    autocmd ColorScheme * highlight ALEError term=underline gui=underline
    autocmd ColorScheme * highlight ALEWarning term=underline gui=underline
    autocmd ColorScheme * highlight ALEInfo term=underline gui=underline

    " set coc and ale colors
    autocmd ColorScheme * highlight! link CocErrorSign diffRemoved
    autocmd ColorScheme * highlight! link CocErrorFloat diffRemoved
    autocmd ColorScheme * highlight! link CocWarningSign diffFile
    autocmd ColorScheme * highlight! link CocWarningFloat diffFile
    autocmd ColorScheme * highlight! link CocHintSign diffFile
    autocmd ColorScheme * highlight! link CocHintFloat diffFile
    autocmd ColorScheme * highlight! link ALEErrorSign diffRemoved
    autocmd ColorScheme * highlight! link ALEWarningSign diffFile
    autocmd ColorScheme * highlight! link ALEInfoSign diffFile

    " change VIM background to terminal background
    " autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE
    " autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
    " autocmd ColorScheme * highlight SignColumn guibg=NONE ctermbg=NONE
    " autocmd ColorScheme * highlight LineNr guibg=NONE ctermbg=NONE

    " do not obscure matching parentheses coloring
    autocmd ColorScheme * hi MatchParen guifg=NONE guibg=NONE gui=bold
    autocmd ColorScheme * hi MatchWord gui=italic,bold

    autocmd ColorScheme * hi Comment gui=italic
augroup END

set background=dark
try
    " GRUVBOX
    let g:gruvbox_invert_selection = 0
    " colorscheme gruvbox

    " GRUVBOX MATERIAL
    let g:gruvbox_material_background = 'hard'
    let g:gruvbox_material_disable_italic_comment = 1
    " colorscheme gruvbox-material

    " BADWOLF
    " colorscheme badwolf

    " SPRINGNIGHT
    colorscheme spring-night

catch
    " fallback color scheme
    colorscheme default
endtry

" override 'vim-log-highlighting'
" autocmd BufRead,BufNewFile * syn match logEmptyLines display '^#.*'
