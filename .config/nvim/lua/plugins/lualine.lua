vim.pack.add { "https://github.com/lewis6991/gitsigns.nvim" }

local M = {}

M.options = {
	statusline = {
		enabled = true,
		a = "%{v:lua.mode()}",
		b = "%{v:lua.git()}",
		c = "%t%m%r%h%w",
		x = "%p%%",
		y = "%l:%c",
		z = "%{&filetype}",
	},
	tabline = {
		enabled = true,
		a = "",
		b = "",
		c = "",
		x = "",
		y = "",
		z = "",
	},

	linecolumn = {
		enabled = true,
		bold = true,
	},

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
		bg = "#24273a",
		dim = "#6e738d",
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

	function _G.color(name, bg, bold, color, transparent)
		if (transparent == 1) then
			vim.api.nvim_set_hl(0, name, {
				bg = M.options.colors.bg,
				fg = M.options.colors.bg,
			})
			return "%#" .. name .. "#"
		end
		if (color == 0) then
			if (bg == 1) then
				vim.api.nvim_set_hl(0, name, {
					bg = M.options.colors.dim,
					fg = M.options.colors.bg,
					bold = bold,
				})
				return "%#" .. name .. "#"
			end
			vim.api.nvim_set_hl(0, name, {
				fg = M.options.colors.dim,
				bg = M.options.colors.bg,
				bold = bold,
			})
			return "%#" .. name .. "#"
		end
		if (bg == 1) then
			vim.api.nvim_set_hl(0, name, {
				bg = M.options.colors[vim.fn.mode()],
				fg = M.options.colors.bg,
				bold = bold,
			})
			return "%#" .. name .. "#"
		end
		vim.api.nvim_set_hl(0, name, {
			fg = M.options.colors[vim.fn.mode()],
			bg = M.options.colors.bg,
			bold = bold,
		})
		return "%#" .. name .. "#"
	end

	if M.options.statusline.enabled == true then
		local s = ""
		if not (M.options.statusline.a == "") then
			s = s ..
				"%{%v:lua.color('StatusLineA', 1, 1)%} " ..
				M.options.statusline.a .. "%{%v:lua.color('StatusLineB')%}" .. M.options.separator.left
		end
		if not (M.options.statusline.b == "") then
			s = s ..
				"%{%v:lua.color('StatusLineB')%} " ..
				M.options.statusline.b .. M.options.separator.leftDim
		end
		if not (M.options.statusline.c == "") then
			s = s ..
				"%{%v:lua.color('StatusLineC', 0, 0, 0)%} " ..
				M.options.statusline.c
		end

		s = s .. "%="

		if not (M.options.statusline.x == "") then
			s = s ..
				"%{%v:lua.color('StatusLineC', 0, 0, 0)%}" ..
				M.options.statusline.x .. " "
		end
		if not (M.options.statusline.y == "") then
			s = s ..
				"%{%v:lua.color('StatusLineB')%}" .. M.options.separator.rightDim .. " " ..
				M.options.statusline.y .. " "
		end
		if not (M.options.statusline.z == "") then
			s = s .. "%{%v:lua.color('StatusLineB')%}" .. M.options.separator.right ..
				"%{%v:lua.color('StatusLineA', 1, 1)%}" .. M.options.statusline.z .. " "
		end

		vim.o.statusline = s
	end
	if M.options.tabline.enabled == true then
		function _G.rendertabline()
			local s = "%{%v:lua.color('TabLineS')%}"
			local tabs = vim.api.nvim_list_tabpages()
			local current = vim.api.nvim_get_current_tabpage()

			if not (M.options.tabline.a == "") then
				s = s ..
					"%{%v:lua.color('StatusLineA', 1, 1)%} " ..
					M.options.tabline.a .. "%{%v:lua.color('StatusLineB')%}" .. M.options.separator.left
			end
			if not (M.options.tabline.b == "") then
				s = s ..
					"%{%v:lua.color('StatusLineB')%} " ..
					M.options.tabline.b .. M.options.separator.leftDim
			end
			if not (M.options.tabline.c == "") then
				s = s ..
					"%{%v:lua.color('StatusLineC', 0, 0, 0)%} " ..
					M.options.tabline.c
			end

			if not (M.options.tabline.x == "") then
				s = s .. "%{%v:lua.color('StatusLineT', 0, 0, 0, 1)%}" ..
					M.options.tabline.x .. " "
			end
			if not (M.options.tabline.y == "") then
				s = s .. M.options.separator.rightDim .. " " ..
					M.options.tabline.y .. " "
			end
			if not (M.options.tabline.z == "") then
				s = s .. M.options.separator.right .. M.options.tabline.z .. " "
			end

			s = s .. "%="

			for i, tab in ipairs(tabs) do
				local active = tab == current

				local hlE = active and "%{%v:lua.color('TabLineS')%}" or "%{%v:lua.color('TabLineI', 0, 0, 0)%}"
				local hlM = active and "%{%v:lua.color('TabLineSM', 1, 1)%}" or "%{%v:lua.color('TabLineIM', 1, 1, 0)%}"

				s = s .. hlE .. M.options.separator.right
				s = s .. hlM .. i
				s = s .. hlE .. M.options.separator.left
				if (tabs[i + 1]) then
					s = s .. " "
				end
			end
			s = s .. "%="

			if not (M.options.tabline.a == "") then
				s = s ..
					"%{%v:lua.color('StatusLineT', 0, 0, 0, 1)%} " .. M.options.tabline.a .. M.options.separator.left
			end
			if not (M.options.tabline.b == "") then
				s = s ..
					M.options.tabline.b .. M.options.separator.leftDim
			end
			if not (M.options.tabline.c == "") then
				s = s ..
					M.options.tabline.c
			end

			if not (M.options.tabline.x == "") then
				s = s .. "%{%v:lua.color('StatusLineC', 0, 0, 0)%}" .. M.options.tabline.x .. " "
			end
			if not (M.options.tabline.y == "") then
				s = s ..
					"%{%v:lua.color('StatusLineB')%}" .. M.options.separator.rightDim .. " " ..
					M.options.tabline.y .. " "
			end
			if not (M.options.tabline.z == "") then
				s = s .. "%{%v:lua.color('StatusLineB')%}" .. M.options.separator.right ..
					"%{%v:lua.color('StatusLineA', 1, 1)%}" .. M.options.tabline.z .. " "
			end

			return s
		end

		vim.o.tabline = "%!v:lua.rendertabline()"
	end
	if M.options.linecolumn.enabled == true then
		color('CursorLineNr', 0, M.options.linecolumn.bold)
		vim.api.nvim_create_autocmd('ModeChanged', {
			callback = function()
				color('CursorLineNr', 0, M.options.linecolumn.bold)
				if (vim.fn.mode() == 'c') then
					vim.cmd.redraw()
				end
			end
		})
	end
end

return M
