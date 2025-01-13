return {
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter"
		},
		config = function()
			local devicons = require('nvim-web-devicons')
			require("neotest").setup({
				icons = {
					passed = "\u{2714}"
				},
				adapters = {
					require('neotest-jest')({
						no_extra = true,
						jestCommand = function(path)
							if string.find(path, "/aqb/") then
								local package_name = string.match(path, "/packages/([^/]+)/src/")
								local filename = string.match(path, "([^/]+)$")
								return "npm run test:file --file=" .. filename .. " --package_name=" .. package_name .. " --coverage='' --output_style='' --coverage_reporters='' -- --json=true"

							else
								return "npm test -- ".. path
							end
						end,
						cwd = function(path)
							return vim.fn.getcwd()
						end,
						jestConfigFile = function(file)
							if string.find(file, "/packages/") then
								return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
							end
							return vim.fn.getcwd() .. "/jest.config.ts"
						end,
					}),
				},
			})
		end
}
