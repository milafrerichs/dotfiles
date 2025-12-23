-- LSP
--
--
-- local nvim_lsp = require 'lspconfig'
-- local protocol = require('vim.lsp.protocol')
-- local on_attach = function(client, bufnr)
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--   if true then -- client.server_capabilities.documentFormattingProvider then
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
--       buffer = bufnr,
-- 			callback = function()
--         vim.lsp.buf.format({ async = true })
-- 			end,
--       -- callback = function() vim.lsp.buf.formatting_seq_sync() end
-- 			-- Add these from ts_ls lsp server
-- 			-- "source.organizeImports": true,
-- 			-- "source.addMissingImports": true,
--     })
-- 	local opts = { noremap = true, silent = true }
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
-- end
-- end

--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--
-- TypeScript
-- nvim_lsp.ts_ls.setup({
--   on_attach = on_attach,
-- })

-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("lsp", { clear = true }),
--   callback = function(args)
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = args.buf,
--       callback = function()
--         vim.lsp.buf.format {async = false, id = args.data.client_id }
--       end,
--     })
--   end
-- })

-- nvim-cmp supports additional completion capabilities.
local lspkind = require("lspkind")

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "avante" },
		{ name = "nvim_lsp_signature_help" },
	}),
	formatting = {
		format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
	},
	cmdline = "/",
	{
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "nvim_lsp_document_symbol" },
			{ name = "buffer" },
		},
	},
})

vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
---local capabilities = require('cmp_nvim_lsp').default_capabilities()
---

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
		},
	},
})
-- vim.lsp.config('ts_ls', {
--     settings = {
--         typescript = {
--             format = {
--                 insertSpaceAfterCommaDelimiter = true,
--                 insertSpaceAfterConstructor = false,
--                 insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
--                 insertSpaceAfterKeywordsInControlFlowStatements = true,
--                 insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
--                 insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
--                 insertSpaceAfterSemicolonInForStatements = true,
--                 insertSpaceBeforeAndAfterBinaryOperators = true,
--                 insertSpaceBeforeFunctionParenthesis = false,
--                 placeOpenBraceOnNewLineForFunctions = false,
--                 placeOpenBraceOnNewLineForControlBlocks = false,
--             },
--             preferences = {
--                 -- Example: prefer type only auto-imports
--                 importModuleSpecifierPreference = "non-relative",
--                 quoteStyle = "single",
--             },
--         },
--         javascript = {
--             -- JavaScript specific settings can go here
--         },
-- 	}
-- })

-- This would typically be in a file like `lua/plugins/lsp.lua`
-- or directly in your `init.lua` if you keep it simple.

-- You still need lspconfig for some utilities or if you manually set up
-- servers not managed by mason-lspconfig/vim.lsp.config
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Define the on_attach function once
-- This function contains all your buffer-local LSP keymaps and autocommands
local on_attach = function(client, bufnr)
	-- Set keymaps for the current buffer (bufnr)
	-- Add `desc` for better discoverability with `:h vim.keymap.set-options`

	-- Your problematic keymaps, now corrected and buffer-local:
	vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP: Go to References" })
	vim.keymap.set("n", "<leader>gf", function()
		vim.lsp.buf.format({ async = true })
	end, { buffer = bufnr, desc = "LSP: Format buffer" })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })
	vim.keymap.set("n", "<leader>H", function()
		vim.lsp.inlay_hint.toggle()
	end, { buffer = bufnr, desc = "LSP: Toggle Inlay Hints" })

	-- Common LSP keymaps (highly recommended to include these)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Go to Declaration" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to Definition" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP: Go to Implementation" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover Documentation" })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename Symbol" })
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "LSP: Type Definition" })
	vim.keymap.set(
		"n",
		"<leader>wa",
		vim.lsp.buf.add_workspace_folder,
		{ buffer = bufnr, desc = "LSP: Add workspace folder" }
	)
	vim.keymap.set(
		"n",
		"<leader>wr",
		vim.lsp.buf.remove_workspace_folder,
		{ buffer = bufnr, desc = "LSP: Remove workspace folder" }
	)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { buffer = bufnr, desc = "LSP: List workspace folders" })
	vim.keymap.set("n", "<leader>sd", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP: Signature Help" })
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

	--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

	-- Optional: Highlight references on cursor hold
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end

	-- Optional: Format on save (ensure client supports it)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormat" .. bufnr, { clear = true }), -- Unique group per buffer
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr, async = false }) -- async=false for pre-save to ensure it finishes
			end,
		})
	end
end

-- List of LSP servers you want to manage with Mason
local servers_to_configure = {
	"lua_ls",
	"rust_analyzer",
	"ruff",
	"ruby_lsp",
	"gopls",
	"html",
	"cssls",
	"ts_ls",
	"jinja_lsp",
	"rubocop",
	"herb_ls",
	"pyright",
}

for _, server_name in ipairs(servers_to_configure) do
	local opts = {
		on_attach = on_attach,
		capabilities = cmp_nvim_lsp.default_capabilities(),
	}

	-- You can add server-specific settings here using if/else if
	if server_name == "lua_ls" then
		opts.settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = {
						"vim",
						"require",
					},
				},
			},
		}
	elseif server_name == "rust_analyzer" then
		opts.settings = {
			["rust-analyzer"] = {
				inlayHints = {
					bindingModeHints = {
						enable = true,
					},
				},
			},
		}
	elseif server_name == "herb_ls" then
		opts.filetypes = { "html", "eruby" }
		-- Add more `elseif` blocks for other server-specific configurations
	end

	-- Apply the configuration for the current server
	vim.lsp.config(server_name, opts)
end

-- Make runtime files discoverable to the server.
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Set completeopt to have a better completion experience.
vim.o.completeopt = "menuone,noselect"

vim.diagnostic.config({
	virtual_text = true, -- Disable virtual text diagnostics
	signs = true, -- Disable diagnostic signs (including the lightbulb)
	underline = true, -- Disable diagnostic underlines
	update_in_insert = false, -- Disable diagnostics while in insert mode
})
