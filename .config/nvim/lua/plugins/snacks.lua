vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})
require('snacks').setup({
	dashboard = {
		enabled = true,
		preset = {
			header = [[
┌───────────────────────────┐
│                           │
│    ███╗   ██╗██╗   ██╗    │
│    ████╗  ██║██║   ██║    │
│    ██╔██╗ ██║██║   ██║    │
│    ██║╚██╗██║╚██╗ ██╔╝    │
│    ██║ ╚████║ ╚████╔╝     │
│    ╚═╝  ╚═══╝  ╚═══╝      │
│                           │
└───────────────────────────┘]],
			keys = {
				{
					desc = "┌───────────────────────────┐"
				},
				{
					desc = "│   Colorschemes           │",
					action = function()
						Snacks.picker.colorschemes()
					end
				},
				{
					desc = "│   Recent Files           │",
					action = function()
						Snacks.dashboard.pick('oldfiles')
					end
				},
				{
					desc = "│ 󰒲  Lazy                   │",
					action = ":Lazy"
				},
				{
					desc = "│   Quit                   │",
					action = ":qa"
				},
				{
					desc = "└───────────────────────────┘",
				},
			}
		},
		sections = {
			{ section = "header", },
			{ section = "keys",   indent = 15, },
		},
	},
})
