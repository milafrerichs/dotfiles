local ollama_endpoint = "127.0.0.1:11434"
local llamafile_endpoint = "127.0.0.1:8080"
return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false, -- set this if you want to always pull the latest change
	opts = {
		debug = false,
		hints = { enabled = false },
		auto_suggestions_provider = "gemma3s",
		rules = {
			project_dir = "./rules/",
			global_dir = vim.fn.expand("~/dotfiles/ai/avanterules/"),
		},
		provider = "claude",
		providers = {
			gemini = {
				model = "gemini-2.0-flash", -- -preview-05-20",
				parse_api_key = function()
					return require("config.secrets").gemini
				end,
				extra_request_body = {
					temperature = 0,
					max_tokens = 4096,
				},
			},
			openai = {
				__inherited_from = "openai",
				endpoint = "https://openrouter.ai/api/v1",
				model = "openai/gpt-5-codex",
				parse_api_key = function()
					return require("config.secrets").open_router_api_key
				end,
			},
			claude = {
				__inherited_from = "openai",
				endpoint = "https://openrouter.ai/api/v1",
				model = "anthropic/claude-sonnet-4.5",
				--endpoint = "https://api.anthropic.com",
				--model = "claude-sonnet-4-20250514",
				parse_api_key = function()
					--return require("config.secrets").claude_api_key
					return require("config.secrets").open_router_api_key
				end,
				extra_request_body = {
					temperature = 0,
					--max_tokens = 4096,
				},
			},
			ollama = {
				endpoint = ollama_endpoint,
				model = "llama3.2",
			},
			qwenl = {
				__inherited_from = "ollama",
				endpoint = llamafile_endpoint,
				model = "qwen",
			},
			gemma3s = {
				__inherited_from = "ollama",
				endpoint = ollama_endpoint,
				model = "gemma3:270m",
			},
			gemma3 = {
				__inherited_from = "ollama",
				endpoint = ollama_endpoint,
				model = "gemma3:1b",
			},
			codestral = {
				__inherited_from = "ollama",
				endpoint = ollama_endpoint,
				model = "codestral:22b-v0.1-q3_K_S",
			},
			claude35 = {
				__inherited_from = "claude",
				model = "claude-3-5-sonnet-latest",
			},
			claude37 = {
				__inherited_from = "claude",
				model = "claude-sonnet-2-7-latest",
			},
		},
		dual_boost = {
			enabled = false,
			first_provider = "llama",
			second_provider = "qwen",
			prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
			timeout = 60000, -- Timeout in milliseconds
		},
		behaviour = {
			auto_suggestions = false, -- Experimental stage //change to true use a very small model
		},
		shortcuts = {
			{
				name = "refactor",
				description = "Refactor code with best practices",
				details = "Automatically refactor code to improve readability, maintainability, and follow best practices while preserving functionality",
				prompt = "Please refactor this code following best practices, improving readability and maintainability while preserving functionality.",
			},
			{
				name = "test",
				description = "Generate unit tests",
				details = "Create comprehensive unit tests covering edge cases, error scenarios, and various input conditions",
				prompt = "Please generate comprehensive unit tests for this code, covering edge cases and error scenarios.",
			},
			-- Add more custom shortcuts...
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante", "mchat" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
