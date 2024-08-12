return {
	"mfussenegger/nvim-dap",
	recommended = true,
	desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",
  lazy = false,
	dependencies = {

		-- fancy UI for the debugger
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "nvim-neotest/nvim-nio","mfussenegger/nvim-dap"  },
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>dr", function() require('dapui').open({ reset = true }) end, desc = "reset ui" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
			opts = {},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
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
			end,
		},

		-- virtual text for the debugger
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},

		-- which key integration
		{
			"folke/which-key.nvim",
			optional = true,
			opts = {
				defaults = {
					["<leader>d"] = { name = "+debug" },
				},
			},
		},

		-- mason.nvim integration
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = "mason.nvim",
			cmd = { "DapInstall", "DapUninstall" },
			opts = {
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_installation = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
          "cpptools"
				},
			},
		},

		-- VsCode launch.json parser
		{
			"folke/neoconf.nvim",
		},
	},

	config = function()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    -- Color scheme for debugger breakpoints
    vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
    vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
    vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
    vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })
    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "", texthl = "orange", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define("DapStopped", { text = "•", texthl = "green", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
    vim.fn.sign_define(
      "DapLogPoint",
      { text = "", texthl = "yellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    ) -- Color scheme for debugger for Debugger

		-- setup dap config by VsCode launch.json file
		-- local vscode = require("dap.ext.vscode")
		-- local _filetypes = require("mason-nvim-dap.mappings.filetypes")
		-- local filetypes = vim.tbl_deep_extend("force", _filetypes, {
		-- 	["node"] = { "javascriptreact", "typescriptreact", "typescript", "javascript" },
		-- 	["pwa-node"] = { "javascriptreact", "typescriptreact", "typescript", "javascript" },
  --     ["cppdbg"] = { "c", "cpp" }
		-- })
		-- local json = require("plenary.json")
		-- vscode.json_decode = function(str)
		-- 	return vim.json.decode(json.json_strip_comments(str))
		-- end
		-- vscode.load_launchjs(nil, filetypes)
    
    vim.keymap.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Breakpoint Condition" })
    vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n",
      "<leader>dc",
      function()
        -- if vim.fn.filereadable('.vscode/launch.json') then
        --   local vscode = require("dap.ext.vscode")
        --   -- local json = require("plenary.json")
        --   -- vscode.json_decode = function(str)
        --   -- 	return vim.json.decode(json.json_strip_comments(str))
        --   -- end
        --   vscode.load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
        -- end
        require('dap').continue()
      end,
     {  desc = "Continue" }
    )
    -- vim.keymap.set("n", "<leader>da", function() require("dap").continue({ before = get_args }) end, { desc = "Run with Args" })
    vim.keymap.set("n",
      "<leader>dC",
      function()
        -- if vim.fn.filereadable('.vscode/launch.json') then
        --   require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
        -- end
        require("dap").run_to_cursor()
      end,
      { desc = "Run to Cursor" }
    )
    vim.keymap.set("n", "<leader>dg", function() require("dap").goto_() end, { desc = "Go to Line (No Execute)" })
    vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>dj", function() require("dap").down() end, { desc = "Down" })
    vim.keymap.set("n", "<leader>dk", function() require("dap").up() end, { desc = "Up" })
    vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last" })
    vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>dO", function() require("dap").step_over() end, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>dp", function() require("dap").pause() end, { desc = "Pause" })
    vim.keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle REPL" })
    vim.keymap.set("n", "<leader>ds", function() require("dap").session() end, { desc = "Session" })
    vim.keymap.set("n", "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate" })
    vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, {desc = "Widgets"})



    local dap = require('dap')
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },
    }
	end,
}
