return {
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'lambdalisue/fern.vim',
	'tpope/vim-repeat',
	'tpope/vim-surround',
	'bronson/vim-trailing-whitespace',
	'tpope/vim-fugitive',
	'airblade/vim-gitgutter',
	'editorconfig/editorconfig-vim',
	'Chiel92/vim-autoformat',
	'chrisbra/csv.vim',
	'dense-analysis/ale',
	'compactcode/alternate.vim',
	'neovim/nvim-lspconfig',
	'hrsh7th/cmp-nvim-lsp',
	'onsails/lspkind-nvim',
	'rmagatti/goto-preview',
	'burntsushi/ripgrep',
	'junegunn/goyo.vim',
	'junegunn/limelight.vim',
	'godlygeek/tabular',
	'elzr/vim-json',
	'plasticboy/vim-markdown',
	{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "typescript", "lua", "vim", "vimdoc", "query", "ruby", "python", "javascript", "html"  }
        })
    end
	},
	{ 'nvim-tree/nvim-web-devicons',
    config = function()
			require('nvim-web-devicons').setup {}
		end
	},
	{
	'nvim-telescope/telescope.nvim', tag = '0.1.4',
	dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
	  'stevearc/aerial.nvim',
	  opts = {},
	  -- Optional dependencies
	  dependencies = {
	     "nvim-treesitter/nvim-treesitter",
	     "nvim-tree/nvim-web-devicons"
		}
	},
	{
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({})
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
	},
	{
		'hrsh7th/nvim-cmp',
    config = function()
        require("cmp").setup({
					snippet = {
						expand = function(args)
							vim.snippet.expand(args.body)
						end
					}
        })
    end
	},
	"nvim-neotest/neotest-jest",
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = { },
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
	{
    'gsuuon/model.nvim',

    -- Don't need these if lazy = false
    cmd = { 'M', 'Model', 'Mchat' },
    init = function()
      vim.filetype.add({
        extension = {
          mchat = 'mchat',
        }
      })
    end,
    ft = 'mchat',

    keys = {
      {'<C-m>d', ':Mdelete<cr>', mode = 'n'},
      {'<C-m>s', ':Mselect<cr>', mode = 'n'},
      {'<C-m><space>', ':Mchat<cr>', mode = 'n' }
    },

    -- To override defaults add a config field and call setup()

    config = function()
			local ollama = require('model.providers.ollama')
			require('model').setup({
				default_prompt = { codellama },
				prompts = {
					codellama = {
						provider = ollama,
						params = {
							model = 'codellama',
						},
						builder = function(input)
							return {
								prompt = '[INST] <><>'
									.. input
									.. '[/INST]'
							}
						end,
					},
				}
			--     chats = {..},
			--     ..
			})
			--
			--   require('model.providers.llamacpp').setup({
			--     binary = '~/path/to/server/binary',
			--     models = '~/path/to/models/directory'
			--   })
    end
  },

}
