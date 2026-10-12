vim.pack.add { "https://github.com/lewis6991/gitsigns.nvim" }

local M = {}

function M.getColorByName(name, bg)
	local ret = vim.api.nvim_get_hl_by_name(name, true)
	return string.format("#%06x", (bg and ret.background or ret.foreground))
end

M.default = {
	statusline = {
		enabled = true,
		a = { "%mode" },
		b = { "%filename" },
		c = { "%git" },
		x = { "%progress" },
		y = { "%location" },
		z = { "%filetype" },
	},
	tabline = {
		enabled = true,
		a = { "" },
		b = { "" },
		c = { "%filename" },
		x = { "" },
		y = { "" },
		z = { "" },
	},

	line_column = {
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
		n = M.getColorByName('Function', false),
		t = M.getColorByName('Function', false),
		i = M.getColorByName('String', false),
		R = M.getColorByName('String', false),
		c = M.getColorByName('Number', false),
		v = M.getColorByName('Keyword', false),
		V = M.getColorByName('Keyword', false),
		[''] = M.getColorByName('Keyword', false),
		bg = M.getColorByName('NormalFloat', true),
		dim = M.getColorByName('Comment', false),
		default = M.getColorByName('Normal', false),
	}
}

function M.setup(opts)
	local options = opts or M.default
	options.statusline = options.statusline or M.default.statusline
	options.tabline = options.tabline or M.default.tabline
	options.line_column = options.line_column or M.default.line_column
	options.separator = options.separator or M.default.separator
	options.colors = options.colors or M.default.colors

	local function git()
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
	local function mode()
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
	local function color(name, bg, bold, color, transparent)
		if (transparent == 1) then
			vim.api.nvim_set_hl(0, name, {
				bg = options.colors.bg,
				fg = options.colors.bg,
			})
			return "%#" .. name .. "#"
		end
		if (color == 0) then
			if (bg == 1) then
				vim.api.nvim_set_hl(0, name, {
					bg = options.colors.dim,
					fg = options.colors.bg,
					bold = bold,
				})
				return "%#" .. name .. "#"
			end
			vim.api.nvim_set_hl(0, name, {
				fg = options.colors.dim,
				bg = options.colors.bg,
				bold = bold,
			})
			return "%#" .. name .. "#"
		end
		if (bg == 1) then
			vim.api.nvim_set_hl(0, name, {
				bg = options.colors[vim.fn.mode()] or options.colors.default,
				fg = options.colors.bg,
				bold = bold,
			})
			return "%#" .. name .. "#"
		end
		vim.api.nvim_set_hl(0, name, {
			fg = options.colors[vim.fn.mode()] or options.colors.default,
			bg = options.colors.bg,
			bold = bold,
		})
		return "%#" .. name .. "#"
	end
	_G.git = git
	_G.mode = mode
	_G.color = color

	local lines = {
		s = {},
	}
	function lines.create(part)
		if (type(part) == "table") then
			for j, string in ipairs(part) do
				if (string == "%mode") then
					lines.s[j] = "%{%v:lua.mode()%}"
				elseif (string == "%filename") then
					lines.s[j] = "%t%m%r%h%w"
				elseif (string == "%filetype") then
					lines.s[j] = "%{&filetype}"
				elseif (string == "%location") then
					lines.s[j] = "%l:%c"
				elseif (string == "%progress") then
					lines.s[j] = "%p%%"
				elseif (string == "%git") then
					lines.s[j] = "%{%v:lua.git()%}"
				else
					lines.s[j] = string
				end
			end
			return table.concat(lines.s, " ")
		end
		if (part == "%mode") then
			return "%{%v:lua.mode()%}"
		elseif (part == "%filename") then
			return "%t%m%r%h%w"
		elseif (part == "%filetype") then
			return "%{&filetype}"
		elseif (part == "%location") then
			return "%l:%c"
		elseif (part == "%progress") then
			return "%p%%"
		elseif (part == "%git") then
			return "%{%v:lua.git()%}"
		else
			return part
		end
	end

	if options.statusline.enabled == true then
		local s = ""

		local status = {
			a = "",
			b = "",
			c = "",
			x = "",
			y = "",
			z = "",
		}


		status.a = lines.create(options.statusline.a)
		status.b = lines.create(options.statusline.b)
		status.c = lines.create(options.statusline.c)
		status.x = lines.create(options.statusline.x)
		status.y = lines.create(options.statusline.y)
		status.z = lines.create(options.statusline.z)

		local a = (not (status.a == nil or status.a == '') and "%{%v:lua.color('StatusLineA', 1, 1)%} " .. status.a .. "%{%v:lua.color('StatusLineB')%}" .. options.separator.left or "")
		local b = (not (status.b == nil or status.b == '') and "%{%v:lua.color('StatusLineB')%} " .. status.b .. options.separator.leftDim or "")
		local c = (not (status.b == nil or status.c == '') and "%{%v:lua.color('StatusLineC', 0, 0, 0)%} " .. status.c or "")
		local x = (not (status.x == nil or status.x == '') and "%{%v:lua.color('StatusLineC', 0, 0, 0)%}" .. status.x .. " " or "")
		local y = (not (status.y == nil or status.y == '') and "%{%v:lua.color('StatusLineB')%}" .. options.separator.rightDim .. " " .. status.y .. " " or "")
		local z = (not (status.z == nil or status.z == '') and "%{%v:lua.color('StatusLineB')%}" .. options.separator.right .. "%{%v:lua.color('StatusLineA', 1, 1)%}" .. status.z .. " " or "")

		s = s .. a .. b .. c .. "%=" .. x .. y .. z

		vim.o.statusline = s
	end

	if options.tabline.enabled == true then
		function _G.rendertabline()
			local function tabs()
				local str = ""
				local _tabs = vim.api.nvim_list_tabpages()
				local current = vim.api.nvim_get_current_tabpage()

				for i, tab in ipairs(_tabs) do
					local is = tab == current

					local hlE = is and "%{%v:lua.color('TabLineS')%}" or "%{%v:lua.color('TabLineI', 0, 0, 0)%}"
					local hlM = is and "%{%v:lua.color('TabLineSM', 1, 1)%}" or "%{%v:lua.color('TabLineIM', 1, 1, 0)%}"

					str = str .. hlE .. options.separator.right
					str = str .. hlM .. i
					str = str .. hlE .. options.separator.left
					if (_tabs[i + 1]) then
						str = str .. " "
					end
				end
				return str
			end

			local tab = {
				a = "",
				b = "",
				c = "",
				x = "",
				y = "",
				z = "",
			}
			tab.a = lines.create(options.tabline.a)
			tab.b = lines.create(options.tabline.b)
			tab.c = lines.create(options.tabline.c)
			tab.x = lines.create(options.tabline.x)
			tab.y = lines.create(options.tabline.y)
			tab.z = lines.create(options.tabline.z)

			local s = "%{%v:lua.color('TabLineS')%}"

			-- MAIN PORTIONS
			local a = (not (tab.a == nil or tab.a == '') and "%{%v:lua.color('StatusLineA', 1, 1)%}" .. tab.a .. "%{%v:lua.color('StatusLineB')%}" .. options.separator.left or "")
			local b = (not (tab.b == nil or tab.b == '') and "%{%v:lua.color('StatusLineB')%}" .. tab.b .. options.separator.leftDim or "")
			local c = (not (tab.b == nil or tab.c == '') and "%{%v:lua.color('StatusLineC', 0, 0, 0)%}" .. tab.c or "")
			local x = (not (tab.x == nil or tab.x == '') and "%{%v:lua.color('StatusLineC', 0, 0, 0)%}" .. tab.x .. " " or "")
			local y = (not (tab.y == nil or tab.y == '') and "%{%v:lua.color('StatusLineB')%}" .. options.separator.rightDim .. " " .. tab.y .. " " or "")
			local z = (not (tab.z == nil or tab.z == '') and "%{%v:lua.color('StatusLineB')%}" .. options.separator.right .. "%{%v:lua.color('StatusLineA', 1, 1)%}" .. tab.z .. " " or "")

			-- TRANSPARENT PORTIONS
			local _a = (not (tab.a == nil or tab.a == '') and "%{%v:lua.color('TabLineT', 0, 0, 0, 1)%}" .. tab.a .. options.separator.left or "")
			local _b = (not (tab.b == nil or tab.b == '') and "%{%v:lua.color('TabLineT', 0, 0, 0, 1)%}" .. tab.b .. options.separator.leftDim or "")
			local _c = (not (tab.b == nil or tab.c == '') and "%{%v:lua.color('TabLineT', 0, 0, 0, 1)%}" .. tab.c or "")
			local _x = (not (tab.x == nil or tab.x == '') and "%{%v:lua.color('TabLineT', 0, 0, 0, 1)%}" .. tab.x or "")
			local _y = (not (tab.y == nil or tab.y == '') and "%{%v:lua.color('TabLineT', 0, 0, 0, 1)%}" .. options.separator.rightDim .. tab.y or "")
			local _z = (not (tab.z == nil or tab.z == '') and "%{%v:lua.color('TabLineT', 0, 0, 0, 1)%}" .. options.separator.right .. tab.z or "")

			s = s .. a .. b .. c .. _x .. _y .. _z .. "%=" .. tabs() .. "%=" .. _a .. _b .. _c .. x .. y .. z


			return s
		end

		vim.o.tabline = "%!v:lua.rendertabline()"
	end
	if options.line_column.enabled == true then
		color('CursorLineNr', 0, options.line_column.bold)
		vim.api.nvim_create_autocmd('ModeChanged', {
			callback = function()
				color('CursorLineNr', 0, options.line_column.bold)
				if (vim.fn.mode() == 'c') then
					vim.cmd.redraw()
				end
			end
		})
	end
	M.options = options
end

return M
