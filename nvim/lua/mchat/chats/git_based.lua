local default_chats = require("model.prompts.chats")
local default_chat = require("mchat.chats.defaults")

local commands = {
	main = { "git", "diff", "main...HEAD" },
	staged = { "git", "diff", "--staged" },
}

local messages = {
	review = "You are an expert programmer that gives constructive feedback. Review the changes in the user's git diff. The diff is provided within the <diff></diff> tags",
	pr = "You are an expert programmer that writes great pull request descriptions. Write a Pull Request description based on the the changes in the user's git diff. The diff is provided within the <diff></diff> tags",
	commit = "You are an expert programmer that writes great commit messages. Write a Comit Message following the conventional commits system based on the the changes in the user's git diff. The diff is provided within the <diff></diff> tags",
}
local default_options = {
	command = "main",
	message = "review",
}

local M = {}

function M.chat(p_options)
	local s_options = p_options or {}
	local options = {}
	for k, v in pairs(default_options) do
		options[k] = v
	end
	for k, v in pairs(s_options) do
		options[k] = v
	end
	local chat = vim.tbl_deep_extend("force", default_chats.gemini, {
		system = messages[options.message],
		create = function(input, context)
			local git_diff = vim.fn.system(commands[options.command])
			---@cast git_diff string

			if not git_diff:match("^diff") then
				error("Git error:\n" .. git_diff)
			end
			return "<diff>" .. git_diff .. "</diff>"
		end,
	})
	return chat
end

return M
