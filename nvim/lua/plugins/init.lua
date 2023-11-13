return {
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
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'onsails/lspkind-nvim',
	'rmagatti/goto-preview',
	'burntsushi/ripgrep',
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
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'light'
      vim.cmd.colorscheme 'solarized'
    end,
  },
}
