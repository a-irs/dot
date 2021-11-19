if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set t_Co=256
    set termguicolors
endif

set background=dark
try
    " GRUVBOX
    " let g:gruvbox_invert_selection = 0
    " colorscheme gruvbox
    " highlight GruvboxGreenSign ctermbg=NONE guibg=NONE ctermfg=142 guifg=#b8bb26
    " highlight GruvboxAquaSign ctermfg=108 ctermbg=NONE guifg=#8ec07c guibg=NONE
    " highlight GruvboxRedSign ctermfg=167 ctermbg=NONE guifg=#fb4934 guibg=NONE

    " GRUVBOX MATERIAL
    " let g:gruvbox_material_background = 'hard'
    " let g:gruvbox_material_disable_italic_comment = 1
    " colorscheme gruvbox-material

    " BADWOLF
    " colorscheme badwolf

    " SPRINGNIGHT
    colorscheme spring-night

    " AYU
    " " let ayucolor='mirage'
    " let ayucolor='dark'
    " colorscheme ayu
    " " background color from 'mirage'
    " highlight Normal guibg=#212733

catch
    " fallback color scheme
    colorscheme default
    highlight StatusLine term=bold,reverse ctermfg=11 ctermbg=242 guifg=yellow guibg=DarkGray
endtry

" clear backgrounds (git gutter, line numbers, ...)
highlight SignColumn guibg=NONE ctermbg=NONE
highlight SignifySignAdd guibg=NONE ctermbg=NONE
highlight SignifySignChange guibg=NONE ctermbg=NONE
highlight SignifySignDelete guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE
highlight FoldColumn guibg=NONE ctermbg=NONE
highlight Folded guibg=NONE ctermbg=NONE
highlight ALEError guibg=NONE ctermbg=NONE
highlight ALEErrorSign guibg=NONE ctermbg=NONE
highlight ALEWarningSign guibg=NONE ctermbg=NONE
highlight ALEInfoSign guibg=NONE ctermbg=NONE

" show invisible chars
set list
set listchars=tab:▸\ ,extends:»,precedes:«
highlight SpecialKey ctermfg=240 guifg=#666666
highlight NonText ctermfg=240 guifg=#666666

" folding
highlight FoldColumn guifg=#8888aa
highlight Folded cterm=bold gui=bold

highlight clear ALEError
highlight clear ALEWarning
highlight clear ALEInfo
highlight ALEError term=underline gui=underline
highlight ALEWarning term=underline gui=underline
highlight ALEInfo term=underline gui=underline

" set coc and ale colors
highlight! link CocErrorSign GitGutterDelete
highlight! link CocErrorFloat GitGutterDelete
highlight! link CocWarningSign GitGutterChange
highlight! link CocWarningFloat GitGutterChange
highlight! link CocHintSign GitGutterChange
highlight! link CocHintFloat GitGutterChange
highlight! link ALEErrorSign GitGutterDelete
highlight! link ALEWarningSign GitGutterChange
highlight! link ALEInfoSign GitGutterChange

" change VIM background to terminal background
" highlight NonText guibg=NONE ctermbg=NONE
" highlight Normal guibg=NONE ctermbg=NONE
" highlight SignColumn guibg=NONE ctermbg=NONE
" highlight LineNr guibg=NONE ctermbg=NONE
