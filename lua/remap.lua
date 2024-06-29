-- Custom remaps

-- Move blocks in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keep cursor position after 'J'
vim.keymap.set('n', 'J', 'mzJ`z')

-- Move cursor to centre after <C-d> or <C-u>
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move cursor to centre when searching
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Paste without yanking
vim.keymap.set('x', '<Leader>p', '"_dP')

-- Yank into system clipboard
vim.keymap.set('n', '<Leader>y', '"+y')
vim.keymap.set('v', '<Leader>y', '"+y')
vim.keymap.set('v', '<Leader>Y', '"+Y')

-- Delete without yanking
vim.keymap.set('n', '<Leader>d', '"_d')
vim.keymap.set('v', '<Leader>d', '"_d')

-- Remap <Esc>
vim.keymap.set('i', 'kj', '<Esc>')
