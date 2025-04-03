vim.api.nvim_exec(
  [[
" THEME CHANGER
function! SetCursorLineNrColorInsert(mode)
" Insert mode: blue
if a:mode == "i"
    call VSCodeNotify('nvim-theme.insert')

" Replace mode: red
elseif a:mode == "r"
    call VSCodeNotify('nvim-theme.replace')
endif
endfunction

augroup CursorLineNrColorSwap
autocmd!
autocmd ModeChanged *:[vV\x16]* call VSCodeNotify('nvim-theme.visual')
autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.replace')
autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
autocmd ModeChanged [vV\x16]*:* call VSCodeNotify('nvim-theme.normal')
augroup END
]],
  false
)
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Setup leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set clipboard to global clipboard
vim.opt.clipboard:append 'unnamedplus'

-- Setup lazy.nvim
require('lazy').setup {
  spec = {
    {
      'folke/flash.nvim',
      event = 'VeryLazy',
      ---@type Flash.Config
      opts = {
        continue = true,
        modes = {
          search = {
            enabled = true,
          },
          char = {
            jump_labels = true,
          },
        },
      },
						-- stylua: ignore
						keys = {
							{ "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
							{ "<leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
							{ "<leader>R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
						},
    },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- Colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'catppuccin-mocha' } },
  { 'neovim/nvim-lspconfig', servers = { pyright = {} } },
}

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('neovim.highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Key Bindings
vim.keymap.set({ 'n', 'x' }, '<leader>c', '"+y')
vim.keymap.set({ 'n', 'x' }, '<leader>v', '"+p')
vim.keymap.set({ 'n', 'x' }, '<leader>V', '"+P')

require 'remap'
