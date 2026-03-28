--- Git-based chat prompts module for AI code review, PR descriptions, and commit messages
--- This module provides functionality to interact with AI providers (Gemini, Claude)
--- to analyze git diffs and generate code reviews, pull request descriptions, or commit messages.
---
--- @module mchat.prompts.git_based

local gemini = require("model.providers.gemini")
local claude = require("model.providers.anthropic")

--- Git commands for retrieving diffs
--- @type table<string, table>
local commands = {
	main = { "git", "diff", "main...HEAD" }, -- Diff between main branch and current HEAD
	staged = { "git", "diff", "--staged" }, -- Diff of staged changes
}

--- Available AI providers
--- @type table<string, table>
local providers = {
	g = gemini, -- Gemini provider (shorthand: 'g')
	c = claude, -- Claude/Anthropic provider (shorthand: 'c')
}

--- System prompts for different message types
--- @type table<string, string>
local messages = {
	review = "You are an expert programmer that gives constructive feedback. Review the changes in the user's git diff. The diff is provided within the <diff></diff> tags",
	pr = "You are an expert programmer that writes great pull request descriptions. Write a Pull Request description based on the the changes in the user's git diff. The diff is provided within the <diff></diff> tags",
	commit = "You are an expert programmer that writes great commit messages. Write a Comit Message following the conventional commits system based on the the changes in the user's git diff. The diff is provided within the <diff></diff> tags",
}

--- Default options for chat configuration
--- @type table
local default_options = {
	command = "main", -- Default git command to use
	message = "review", -- Default message type
	provider = "c", -- Default provider (Claude)
}

local M = {}

--- Creates a chat configuration for git-based AI interactions
--- This function sets up a chat session with an AI provider to analyze git diffs
--- and generate responses based on the specified message type (review, PR, or commit).
---
--- @param p_options table Options to configure the chat
--- @param p_options.command? string Git command to use: "main" or "staged" (default: "main")
--- @param p_options.message? string Message type: "review", "pr", or "commit" (default: "review")
--- @param p_options.provider? string AI provider: "g" (Gemini) or "c" (Claude) (default: "c")
---
--- @return table chat_config A table containing the provider and builder function
--- @return table chat_config.provider The AI provider instance
--- @return function chat_config.builder Function that builds the prompt with git diff context
---
--- @usage
--- local git_based = require("mchat.prompts.git_based")
---
--- -- Create a code review chat for changes between main and HEAD
--- local review_chat = git_based.chat({ command = "main", message = "review", provider = "c" })
---
--- -- Create a PR description chat for staged changes
--- local pr_chat = git_based.chat({ command = "staged", message = "pr" })
---
--- -- Create a commit message chat
--- local commit_chat = git_based.chat({ message = "commit" })
---
--- @throws error If git command fails or returns invalid output
function M.chat(p_options)
	-- Merge default options with provided options
	local options = {}
	for k, v in pairs(default_options) do
		options[k] = v
	end
	for k, v in pairs(p_options) do
		options[k] = v
	end

	-- Get the selected AI provider
	local prompt = providers[options.provider]
	print(prompt)

	-- Set the system prompt based on message type
	prompt.set_system_prompt(messages[options.message])

	return {
		provider = prompt.provider,
		--- Builder function that retrieves git diff and constructs the prompt
		--- @param input string User input/query
		--- @return table The built prompt ready for the AI provider
		builder = function(input)
			-- Execute git command to get the diff
			local git_diff = vim.fn.system(commands[options.command])
			---@cast git_diff string

			-- Validate that we got a valid git diff
			if not git_diff:match("^diff") then
				error("Git error:\n" .. git_diff)
			end

			-- Add git diff as context wrapped in XML-like tags
			prompt.add_context("user", "<diff>" .. git_diff .. "</diff>")

			-- Build and return the final prompt
			return prompt.builder(input)
		end,
	}
end

return M
