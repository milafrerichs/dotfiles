local opts = { noremap = true, silent = true }

vim.g.mapleader = ","
vim.api.nvim_set_keymap( "i", "jj", "<Esc>", { noremap = true })

vim.api.nvim_set_keymap( "n", "<C-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap( "n", "<C-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap( "n", "<C-h>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap( "n", "<C-l>", "<C-w>l", { noremap = true })

vim.api.nvim_set_keymap( "n", "<Leader>p", ':set paste<CR>o<esc>"*]p:set nopaste<cr>', {})

vim.api.nvim_set_keymap( "n", "<silent><F2>", ":lnext<CR>", { noremap = true })
vim.api.nvim_set_keymap( "i", "<silent><F2>", "<C-O>:lnext<CR>", { noremap = true })
vim.api.nvim_set_keymap( "v", "<silent><F2>", ":lnext<CR>", { noremap = true })
--vim.keymap.set( "n", "<leader>pf", builtin.find_files, {})
--vim.keymap.set( "n", "<C-p>", builtin.git_files, {})

--vim.api.nvim_set_keymap('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
--vim.api.nvim_set_keymap('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.api.nvim_set_keymap('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

vim.keymap.set('n', '<Leader>g', '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>', {noremap=true, silent=true})
vim.keymap.set('n', '<Leader>gv', '<cmd>lua require"telescope.builtin".lsp_definitions({jump_type="vsplit"})<CR>', {noremap=true, silent=true})
vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})

vim.keymap.set("n", '<C-f>', '<Cmd>Fern . -reveal=%', {})

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

vim.keymap.set('v', '<Leader>gs', function()
	local text = vim.getVisualSelection()
	tb.current_buffer_fuzzy_find({ default_text = text })
end, opts)

vim.keymap.set('n', '<Leader>G', ':Telescope live_grep<cr>', opts)
vim.keymap.set('v', '<Leader>fs', function()
	local text = vim.getVisualSelection()
	tb.live_grep({ default_text = text })
end, opts)
