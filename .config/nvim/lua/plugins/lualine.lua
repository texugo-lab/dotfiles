vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
	'https://github.com/nvim-tree/nvim-web-devicons'
})
require('lualine').setup({
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = {},
		lualine_y = { 'location' },
		lualine_z = { 'filetype' },
	},
	tabline = {
		lualine_a = { 'filename' },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { 'tabs' }
	},
})
