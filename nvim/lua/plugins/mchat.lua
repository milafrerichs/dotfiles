-- Prompts = inline chats
-- Chats Started with Mchat chat_name opens new buffer

local gemini = require("model.providers.gemini")
local openai = require("model.providers.openai")
local default_chats = require("model.prompts.chats")
local default_prompts = require("model.prompts.starters")
local code_review_prompt = require("mchat.prompts.code_review")
-- ToDO: fix the providers part
--local git_based_prompts = require("mchat.prompts.git_based")
local add_tests_prompt = require("mchat.prompts.add_test")
local add_tests_chat = require("mchat.chats.add_test")
local git_based_chat = require("mchat.chats.git_based")
local prompts = default_prompts
local chats = default_chats
prompts.codellama = {
	provider = ollama,
	params = {
		model = "codellama",
	},
	builder = function(input)
		return {
			prompt = "[INST] <><>" .. input .. "[/INST]",
		}
	end,
}
--prompts["cr"] = git_based_prompts.chat({ message = "review" })
--prompts["crs"] = git_based_prompts.chat({ message = "review", command = "staged" })
--prompts["cms"] = git_based_prompts.chat({ message = "commit", command = "staged" })

chats["code review"] = git_based_chat.chat()
chats["code review staged"] = git_based_chat.chat({ command = "staged" })
chats["pull request"] = git_based_chat.chat({ message = "pr" })
chats["commit message"] = git_based_chat.chat({ message = "commit" })
--chats["code review staged"] = code_review_chat.chat()
chats["add_tests"] = add_tests_chat.chat()

local default_p = vim.tbl_extend("force", openai.default_prompt, {
	provider = openai,
	params = {
		model = "anthropic/claude-sonnet-4.5",
	},
	options = {
		url = "https://openrouter.ai/api/v1",
		authorization = "Bearer " .. require("config.secrets").open_router_api_key,
	},
})

chats["d"] = vim.tbl_extend("force", default_chats.openai, {
	params = {
		model = "anthropic/claude-sonnet-4.5",
	},
	options = {
		url = "https://openrouter.ai/api/v1",
		authorization = "Bearer " .. require("config.secrets").open_router_api_key,
	},
})
chats["codex"] = vim.tbl_extend("force", chats.d, {
	params = {
		model = "openai/gpt-5.1-codex",
	},
})
chats["codex-m"] = vim.tbl_extend("force", chats.d, {
	params = {
		model = "openai/gpt-5.1-codex-mini",
	},
})
chats["o"] = vim.tbl_extend("force", chats.d, {
	params = {
		model = "anthropic/claude-opus-4.5",
	},
})
chats["g"] = vim.tbl_extend("force", chats.d, {
	params = {
		model = "google/gemini-3-pro-preview",
	},
})
return {
	"gsuuon/model.nvim",

	-- Don't need these if lazy = false
	cmd = { "M", "Model", "Mchat" },
	init = function()
		vim.filetype.add({
			extension = {
				mchat = "mchat",
			},
		})
	end,
	opts = {
		default_prompt = default_p,
		secrets = {
			GOOGLE_API_KEY = function()
				return require("config.secrets").gemini
			end,
			ANTHROPIC_API_KEY = function()
				return require("config.secrets").claude_api_key
			end,
		},
		prompts = prompts,
		chats = chats,
	},
	ft = "mchat",

	keys = {
		{ "<C-m>d", ":Mdelete<cr>", mode = "n" },
		{ "<C-m>s", ":Mselect<cr>", mode = "n" },
		{ "<C-m><space>", ":Mchat<cr>", mode = "n" },
	},

	-- To override defaults add a config field and call setup()

	-- config = function()
	-- 	local ollama = require("model.providers.ollama")
	-- 	require("model").setup({
	-- 		default_prompt = { codellama },
	-- 		prompts = {
	-- 			codellama = {
	-- 				provider = ollama,
	-- 				params = {
	-- 					model = "codellama",
	-- 				},
	-- 				builder = function(input)
	-- 					return {
	-- 						prompt = "[INST] <><>" .. input .. "[/INST]",
	-- 					}
	-- 				end,
	-- 			},
	-- 		},
	-- 		--     chats = {..},
	-- 		--     ..
	-- 	})
	-- 	--
	-- 	--   require('model.providers.llamacpp').setup({
	-- 	--     binary = '~/path/to/server/binary',
	-- 	--     models = '~/path/to/models/directory'
	-- 	--   })
	-- end,
}
