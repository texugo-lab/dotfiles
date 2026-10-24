vim.g.mapleader = " "
vim.keymap.set('n', '<leader>r', ":source ~/.config/nvim/init.lua<CR>")

vim.keymap.set('c', '<C-h>', [[<Left>]])
vim.keymap.set('c', '<C-j>', [[<Down>]])
vim.keymap.set('c', '<C-k>', [[<Up>]])
vim.keymap.set('c', '<C-l>', [[<Right>]])

vim.keymap.set('n', '<leader>fo', function() Snacks.dashboard.pick('oldfiles') end)
vim.keymap.set('n', '<leader>th', function() Snacks.picker.colorschemes() end)
