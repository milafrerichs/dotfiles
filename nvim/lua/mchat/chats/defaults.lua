local default_chats = require("model.prompts.chats")

local chat = vim.tbl_extend("force", default_chats.openai, {
	params = {
		model = "anthropic/claude-sonnet-4.5",
	},
	options = {
		url = "https://openrouter.ai/api/v1",
		authorization = "Bearer " .. require("config.secrets").open_router_api_key,
	},
})

return chat
