return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"ruff",
				"ruby_lsp",
				"gopls",
				"html",
				"ts_ls",
				"jinja_lsp",
				"rubocop",
				"herb_ls",
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"lambdalisue/vim-fern-bookmark",
		dependencies = {
			"lambdalisue/fern.vim",
		},
	},
	"tpope/vim-repeat",
	"tpope/vim-surround",
	"bronson/vim-trailing-whitespace",
	"tpope/vim-fugitive",
	"airblade/vim-gitgutter",
	"editorconfig/editorconfig-vim",
	"Chiel92/vim-autoformat",
	"chrisbra/csv.vim",
	"compactcode/alternate.vim",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp-document-symbol",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"onsails/lspkind-nvim",
	"rmagatti/goto-preview",
	"burntsushi/ripgrep",
	"junegunn/goyo.vim",
	"junegunn/limelight.vim",
	"godlygeek/tabular",
	"elzr/vim-json",
	"plasticboy/vim-markdown",
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"typescript",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"ruby",
				"python",
				"javascript",
				"html",
				"mchat",
			},
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jonarrien/telescope-cmdline.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"sato-s/telescope-rails.nvim",
		},
		keys = {
			{ "Q", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
			{ "<leader><leader>", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
			{ "<leader>trs", "<cmd>Telescope rails specs<cr>", desc = "Rails" },
		},
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						hidden = true,
						theme = "ivy",
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("cmdline")
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("rails")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		end,
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		opts = {
			lightbulb = {
				enable = false,
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"hrsh7th/nvim-cmp",
		--config = function()
		--		require("cmp").setup({
		--			show_message = false,
		--			snippet = {
		--				expand = function(args)
		--					vim.snippet.expand(args.body)
		--				end,
		--			},
		--		})
		--	end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
