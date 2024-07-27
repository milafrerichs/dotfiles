local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.api.nvim_set_keymap( "i", "jj", "<Esc>", { noremap = true })

vim.api.nvim_set_keymap( "n", "<C-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap( "n", "<C-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap( "n", "<C-h>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap( "n", "<C-l>", "<C-w>l", { noremap = true })

vim.api.nvim_set_keymap( "n", "<Leader>p", ':set paste<CR>o<esc>"*]p:set nopaste<cr>', {})

vim.api.nvim_set_keymap( "n", "<silent><F2>", ":lnext<CR>", { noremap = true })
vim.api.nvim_set_keymap( "i", "<silent><F2>", "<C-O>:lnext<CR>", { noremap = true })
vim.api.nvim_set_keymap( "v", "<silent><F2>", ":lnext<CR>", { noremap = true })


vim.api.nvim_set_keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.api.nvim_set_keymap('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
--vim.api.nvim_set_keymap('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
--vim.api.nvim_set_keymap('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
