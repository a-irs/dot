return {
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()

    -- https://github.com/lukas-reineke/indent-blankline.nvim/issues/824
    local hooks = require "ibl.hooks"
    hooks.register(
        hooks.type.VIRTUAL_TEXT,
        function(_, _, _, virt_text)
            if virt_text[1] and virt_text[1][1] == '▏' then
                virt_text[1] = { ' ', { "@ibl.whitespace.char.1" } }
            end
            return virt_text
        end
    )
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#364353" })
    end)

    require("ibl").setup {
        indent = { char = "▏" },
        scope = { enabled = false }
    }
    end
  },
  {
    'gelguy/wilder.nvim',
    config = function()
      require('wilder').setup({
          modes = { ':', '/', '?' }
      })
    end
  },

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
        -- win = {
        --   margin = { 0, 0, 0, 0 },
        --   padding = { 1, 1, 1, 1 },
        -- },
        icons = {
            mappings = false
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
        nnoremap <silent> <leader>cc :Make<CR>
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
        let g:slime_no_mappings = 1

        " default: SlimeParagraphSend
        nmap <c-c><c-c> <Plug>SlimeLineSend
        xmap <c-c><c-c> <Plug>SlimeRegionSend \| gv

        " send whole file
        nmap <c-c><c-v> :%SlimeSend<CR>

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
