local dap = require("dap")

dap.adapters.gdb = {
	id = 'gdb',
	type = 'executable',
	command = '/usr/bin/gdb',
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

local c_cpp_config = {
	{
		name = 'Run executable with arguments (GDB)',
		type = 'gdb',
		request = 'launch',
		-- This requires special handling of 'run_last', see
		-- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
		program = function()
			local path = vim.fn.input({
				prompt = 'Path to executable: ',
				default = vim.fn.getcwd() .. '/',
				completion =
				'file',
			})

			return (path and path ~= '') and path or dap.ABORT
		end,
		args = function()
			local args_str = vim.fn.input({
				prompt = 'Arguments: ',
			})
			return vim.split(args_str, ' +')
		end,
	},
}
dap.configurations.c = c_cpp_config
dap.configurations.cpp = c_cpp_config
