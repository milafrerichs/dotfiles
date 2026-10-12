-- my_gemini_builder_module.lua

-- Standard module table to hold public functions and data
local M = {}

-- Variable to store the system prompt, initialized with a default value
local system_prompt_text = "You are an intelligent programming assistant"
local context_messages = {}

--- Function to set the system prompt for the builder.
--- This allows configuring the system prompt from outside the module.
--- @param prompt string The new system prompt text.
function M.set_system_prompt(prompt)
  system_prompt_text = prompt
	return M
end

--- Adds a message to the context history.
--- These messages will be included in the 'contents' list before the current user input
--- when Builder is called.
--- Note: For simplicity, this assumes text-only messages.
---
--- @param role string The role of the message ("user" or "model").
--- @param content string The text content of the message.
function M.add_context(role, content)
  -- Format the message according to Gemini's 'contents' structure
  local message = {
    role = role,
    parts = {
      { text = content }
    }
  }
  -- Add the formatted message to our context list
  table.insert(context_messages, message)
  return M -- Allow chaining
end

--- Clears the stored context messages.
--- Call this to start a new conversation thread.
function M.clear_context()
  context_messages = {}
  return M -- Allow chaining
end

--- The builder function to format user input and the current system prompt
--- into the basic JSON structure required by the Gemini API's generateContent endpoint.
--- It creates the 'systemInstruction' and 'contents' fields.
--- This function captures the 'system_prompt_text' variable from the enclosing scope.
---
--- @param input string The user's message.
--- @return table The request body table formatted for Gemini.
M.builder = function(input)
	local final_contents = {}

  -- Add all the stored context messages first
  for _, msg in ipairs(context_messages) do
    table.insert(final_contents, msg)
  end

  -- Add the current user message after the context
  local current_user_message = {
    role = "user", -- The role for the actual user's message
    parts = {
      { text = input } -- The user's input goes into a text part
    }
  }
  table.insert(final_contents, current_user_message)

  local request_body = {
    systemInstruction = {
      role = "user",
      parts = {
        { text = system_prompt_text }
      }
    },
		contents = final_contents,
  }
	context_messages = {}

  return request_body
end

-- Add the provider module as requested.
-- NOTE: This line assumes that a Lua module exists at the path
-- "models.providers.gemini" and that requiring it returns the necessary
-- Gemini provider object/table (similar to the original code block you provided).
-- You might need to adjust this path based on your project's structure.
M.provider = require("model.providers.gemini")

-- Return the module table
return M
