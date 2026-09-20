vim.keymap.set('n', '<C-t>p', ":tabp<CR>")
vim.keymap.set('n', '<C-t>n', ":tabn<CR>")

vim.keymap.set('n', '<Leader>r', ":source ~/.config/nvim/init.lua<CR>")

vim.keymap.set('c', '<C-h>', [[<Left>]])
vim.keymap.set('c', '<C-j>', [[<Down>]])
vim.keymap.set('c', '<C-k>', [[<Up>]])
vim.keymap.set('c', '<C-l>', [[<Right>]])

vim.keymap.set('n', '<Leader>fo', function() Snacks.dashboard.pick('oldfiles') end)
vim.keymap.set('n', '<Leader>th', function() Snacks.picker.colorschemes() end)
