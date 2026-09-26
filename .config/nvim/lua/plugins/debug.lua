return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	lazy = false,
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dapui.setup({
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.75,
						},
						{
							id = "stacks",
							size = 0.25,
						},
					},
					position = "left",
					size = 40
				},
				{
					elements = {
						{
							id = "console",
							size = 1,
						}
					},
					position = "bottom",
					size = 10
				}
			},
		})
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end


		vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
		vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F6>", dap.restart)
		vim.keymap.set("n", "<F7>", dap.terminate)


		require("plugins.dap.c")
	end
}
