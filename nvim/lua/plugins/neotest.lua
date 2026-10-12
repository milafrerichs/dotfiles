return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		'nvim-neotest/neotest-vim-test',
		"zidhuss/neotest-minitest",
		"olimorris/neotest-rspec",
		"nvim-neotest/neotest-python",
		"marilari88/neotest-vitest",
	},
	config = function()
		local devicons = require('nvim-web-devicons')
		require("neotest").setup({
			-- icons = {
			-- passed = "\u{2714}"
			-- },
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-rspec"),
				require("neotest-minitest"),
				require("neotest-vim-test")({
					ignore_file_types = { "python", "vim", "lua" },
				}),
				require("neotest-vitest")({
					vitestCommand = "encore test"
				}),
			},
		})
	end
}
