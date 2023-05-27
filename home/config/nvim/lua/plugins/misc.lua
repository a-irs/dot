return {
  {
    "chrisbra/Colorizer",
    config = function()
      vim.cmd [[
        let g:colorizer_auto_filetype='css,html,conf,lua,sh,dosini,yaml'
        let g:colorizer_colornames = 0  "do not colorize simple 'red', 'yellow', ...
      ]]
    end
  },
  -- better ft=sh, see https://www.reddit.com/r/vim/comments/c6supj/vimsh_better_syntax_highlighting_for_shell_scripts/
  'arzg/vim-sh',

  -- increase/decrease/toggle everything with ctrl+a/ctrl+x
  'Konfekt/vim-CtrlXA',

  {
    "tpope/vim-dispatch",
    config = function()
      vim.cmd [[
        map <silent> <C-y> :Make<CR>
        set errorformat=%m  " anything is shown in quickfix window instead of errors only
      ]]
    end
  },

  {
    "ap/vim-buftabline",
    config = function()
      vim.cmd [[
        set hidden
        let g:buftabline_show = 1
      ]]
    end
  },

}
