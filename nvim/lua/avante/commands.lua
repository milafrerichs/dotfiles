local secrets = require("config.secrets")

local function getClaudeApiKey()
    return secrets.claude_api_key
end

return { getClaudeApiKey = getClaudeApiKey }
