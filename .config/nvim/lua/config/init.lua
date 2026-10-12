require('config.keymaps')
require('config.lsp')
vim.cmd('colorscheme catppuccin-macchiato')

vim.o.relativenumber = true
vim.o.number = true

vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = false

vim.o.wrap = false

vim.o.autocomplete = true
vim.opt.complete:append('o')
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.o.pumheight = 10
vim.o.pumborder = 'rounded'

vim.opt.whichwrap:append("<>[]hl")

vim.o.clipboard = "unnamedplus"
-- HELLO
vim.o.cursorline = true
vim.o.cursorlineopt = "both"

local lualine = require('plugins.lualine')
lualine.setup({
	colors = {
		n = lualine.getColorByName('Function', false),
		t = lualine.getColorByName('Function', false),
		i = lualine.getColorByName('String', false),
		R = lualine.getColorByName('String', false),
		c = lualine.getColorByName('Boolean', false),
		v = lualine.getColorByName('Keyword', false),
		V = lualine.getColorByName('Keyword', false),
		[''] = lualine.getColorByName('Keyword', false),
		bg = lualine.getColorByName('Normal', true),
		dim = lualine.getColorByName('LineNr', false),
		default = lualine.getColorByName('@text', false),
	}
})
