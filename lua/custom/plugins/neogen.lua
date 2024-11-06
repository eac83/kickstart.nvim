return {
  'danymat/neogen',
  opts = true,
  keys = {
    {
      '<leader>ds',
      function()
        require('neogen').generate()
      end,
      desc = 'Add Docstring',
    },
  },
}
