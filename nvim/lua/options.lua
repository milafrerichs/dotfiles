vim.g.ale_linters = {
	typescript = {'eslint', 'tslint'},
	ruby = {'rubocop'},
	jsx = {'stylelint', 'eslint', 'tslint'},
	python = { 'ruff' }
}

vim.g.ale_fixers = {
	['*'] = {'remove_trailing_lines', 'trim_whitespace'},
	python = { 'ruff' }
}

vim.g['ale_completion_autoimport'] = 0
vim.g['ale_completion_enabled'] = 0
vim.g['ale_linters_explicit'] = 1
vim.g['ale_set_quickfix'] = 1

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true

vim.opt.history=500
vim.opt.ruler = true
vim.opt.showcmd	= true
vim.opt.laststatus=2
vim.opt.gdefault = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.encoding= 'utf-8'
vim.opt.ignorecase = true

