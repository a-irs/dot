return {
  {
    dir = "",
    config = function()
      local rc = debug.getinfo(1).source:sub(2):gsub("%.lua", ".vim")
      vim.cmd("source " .. rc)
    end
  },

  -- dark color schemes
  'morhetz/gruvbox',
  'sjl/badwolf',
  'rhysd/vim-color-spring-night',
  'sainnhe/gruvbox-material',
  'NLKNguyen/papercolor-theme',

  -- light color schemes
  'endel/vim-github-colorscheme',
}
