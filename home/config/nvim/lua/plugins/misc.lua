return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.cmd [[
          set timeout
          set timeoutlen=500
        ]]
    end,
    opts = {
        window = {
          margin = { 0, 0, 0, 0 },
          padding = { 1, 1, 1, 1 },
        },
        show_help = false
      }
  },

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

  -- readline mappings: CTRL-A, CTRL-E etc. in insert and command mode
  "tpope/vim-rsi",

   -- send lines to tmux/REPL
   {
     "jpalardy/vim-slime",
     config = function()
       vim.cmd [[
         let g:slime_target = "tmux"
         let g:slime_paste_file = tempname()
         let g:slime_bracketed_paste = 1

         " default: SlimeParagraphSend
         nmap <c-c><c-c> <Plug>SlimeLineSend

         func! SetTmuxWindow(entry)
           let b:slime_config["target_pane"] = split(a:entry, ' ')[0]
         endfunc

         function SlimeOverrideConfig()
           let b:slime_config = {"socket_name": "default"}
           call fzf#run(fzf#wrap({'source': 'tmux-list-repl', 'sink': function('SetTmuxWindow')}))
         endfunction
       ]]
    end
  },
}
