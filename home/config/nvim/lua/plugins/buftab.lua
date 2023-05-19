return {
  {
    "ap/vim-buftabline",
    config = function()
      vim.cmd [[
        set hidden
        let g:buftabline_show = 1
      ]]
    end
  }
}

