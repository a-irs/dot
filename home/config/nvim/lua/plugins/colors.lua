return {
  {
    dir = "",
    name = "colors",
    config = function()
      local rc = debug.getinfo(1).source:sub(2):gsub("%.lua", ".vim")
      vim.cmd("source " .. rc)
    end,
    priority = -1,  -- default: 50
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
