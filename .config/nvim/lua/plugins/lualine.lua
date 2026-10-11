local M = {}

vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim"
})

M.options = {
	statusLine = {
		a = "%{v:lua.mode()}",
		b = "%{v:lua.git()}",
		c = "%t%m%r%h%w",
		x = "%p%%",
		y = "%l:%c",
		z = "%{&filetype}",
	},

	statusline = true,
	tabline = true,
	lineColumn = true,

	separator = {
		right = "",
		left = "",
		rightDim = "",
		leftDim = "",
	},

	colors = {
		n = "#8aadf4",
		t = "#8aadf4",
		i = "#a6da95",
		R = "#a6da95",
		c = "#f5a97f",
		v = "#c6a0f6",
		V = "#c6a0f6",
		[''] = "#c6a0f6",
	}
}

function M.setup(opts)
	M.options = opts or M.options
	function _G.git()
		local git_info = vim.b.gitsigns_status_dict
		if not git_info or git_info.head == "" then
			return ""
		end

		local head    = git_info.head
		local added   = git_info.added and (" +" .. git_info.added) or ""
		local changed = git_info.changed and (" ~" .. git_info.changed) or ""
		local removed = git_info.removed and (" -" .. git_info.removed) or ""
		if git_info.added == 0 then added = "" end
		if git_info.changed == 0 then changed = "" end
		if git_info.removed == 0 then removed = "" end

		return table.concat({
			" ", -- branch icon
			head,
			added, changed, removed,
			"",
		})
	end

	function _G.mode()
		local modes = {
			["n"] = "NORMAL",
			["no"] = "NORMAL",
			["v"] = "VISUAL",
			["V"] = "V-LINE",
			[""] = "V-BLOCK",
			["s"] = "SELECT",
			["S"] = "S-LINE",
			[""] = "S-BLOCK",
			["i"] = "INSERT",
			["ic"] = "INSERT",
			["R"] = "REPLACE",
			["Rv"] = "V-REPLACE",
			["c"] = "COMMAND",
			["cv"] = "EX",
			["ce"] = "EX",
			["r"] = "PROMPT",
			["rm"] = "MOAR",
			["r?"] = "CONFIRM",
			["!"] = "SHELL",
			["t"] = "TERMINAL",
		}
		return modes[vim.fn.mode()]
	end

	function _G.color(name, bg, bold, color)
		if (color == 0) then
			if (bg == 1) then
				vim.api.nvim_set_hl(0, name, {
					bg = "#6e738d",
					fg = "#24273a",
					bold = bold,
				})
				return "%#" .. name .. "#"
			end
			vim.api.nvim_set_hl(0, name, {
				fg = "#6e738d",
				bg = "#24273a",
				bold = bold,
			})
			return "%#" .. name .. "#"
		end
		if (bg == 1) then
			vim.api.nvim_set_hl(0, name, {
				bg = M.options.colors[vim.fn.mode()],
				fg = "#24273a",
				bold = bold,
			})
			return "%#" .. name .. "#"
		end
		vim.api.nvim_set_hl(0, name, {
			fg = M.options.colors[vim.fn.mode()],
			bg = "#24273a",
			bold = bold,
		})
		return "%#" .. name .. "#"
	end

	if M.options.statusline == true then
		local s = ""
		if not (M.options.statusLine.a == "") then
			s = s ..
				"%{%v:lua.color('StatusLineA', 1, 1)%} " ..
				M.options.statusLine.a .. "%{%v:lua.color('StatusLineB')%}" .. M.options.separator.left
		end
		if not (M.options.statusLine.b == "") then
			s = s ..
				"%{%v:lua.color('StatusLineB')%} " ..
				M.options.statusLine.b .. M.options.separator.leftDim
		end
		if not (M.options.statusLine.c == "") then
			s = s ..
				"%{%v:lua.color('StatusLineC', 0, 0, 0)%} " ..
				M.options.statusLine.c
		end

		s = s .. "%="

		if not (M.options.statusLine.x == "") then
			s = s ..
				"%{%v:lua.color('StatusLineC', 0, 0, 0)%}" ..
				M.options.statusLine.x .. " "
		end
		if not (M.options.statusLine.y == "") then
			s = s ..
				"%{%v:lua.color('StatusLineB')%}" .. M.options.separator.rightDim .. " " ..
				M.options.statusLine.y .. " "
		end
		if not (M.options.statusLine.z == "") then
			s = s .. "%{%v:lua.color('StatusLineB')%}" .. M.options.separator.right ..
				"%{%v:lua.color('StatusLineA', 1, 1)%}" .. M.options.statusLine.z .. " "
		end

		vim.o.statusline = s
	end
	if M.options.tabline == true then
		function _G.rendertabline()
			local t = "%{%v:lua.color('TabLineS')%}%="
			local tabs = vim.api.nvim_list_tabpages()
			local current = vim.api.nvim_get_current_tabpage()

			for i, tab in ipairs(tabs) do
				local active = tab == current

				local hlE = active and "%{%v:lua.color('TabLineS')%}" or "%{%v:lua.color('TabLineI', 0, 0, 0)%}"
				local hlM = active and "%{%v:lua.color('TabLineSM', 1, 1)%}" or "%{%v:lua.color('TabLineIM', 1, 1, 0)%}"

				t = t .. hlE .. M.options.separator.right
				t = t .. hlM .. i
				t = t .. hlE .. M.options.separator.left
				if (tabs[i + 1]) then
					t = t .. " "
				end
			end
			t = t .. "%="
			return t
		end

		vim.o.tabline = "%!v:lua.rendertabline()"
	end
	if M.options.lineColumn == true then
		color('CursorLineNr', 0, 1)
		vim.api.nvim_create_autocmd('ModeChanged', {
			callback = function()
				color('CursorLineNr', 0, 1)
				if (vim.fn.mode() == 'c') then
					vim.cmd.redraw()
				end
			end
		})
	end
end

return M
