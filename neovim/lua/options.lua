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

local opt = vim.opt

opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true

opt.history=500
opt.ruler = true
opt.showcmd	= true
opt.laststatus=2
opt.gdefault = true
opt.autoindent = true
opt.encoding= 'utf-8'
opt.ignorecase = true

vim.api.nvim_create_autocmd( "BufWinEnter", {
  pattern = "Jenkinsfile",
	command  = "set filetype=groovy"
})
