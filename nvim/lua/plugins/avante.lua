local ollama_endpoint = "127.0.0.1:11434"
local llamafile_endpoint = "127.0.0.1:8080"
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
	debug = true,
  version = false, -- set this if you want to always pull the latest change
  opts = {
		debug = true,
		hints = { enabled = false },
		--auto_suggestions_provider = "gemma3s",
		provider = "gemini",
		gemini = {
			model = "gemini-2.0-flash",
			parse_api_key = function()
        return require("config.secrets").gemini
      end,
			temperature = 0,
			max_tokens = 4096,
		},
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-3-5-sonnet-20241022",
			parse_api_key = function()
        return require("config.secrets").claude_api_key
      end,
			--api_key_name = "cmd:ClaudeAPO",
			temperature = 0,
			max_tokens = 4096,
		},
		codestral = {
      endpoint = ollama_endpoint,
      model = "codestral:22b-v0.1-q3_K_S",
		},
		llama = {
      endpoint = ollama_endpoint,
      model = "llama3.2",
		},
		gemma3s = {
      endpoint = ollama_endpoint,
      model = "gemma3:1b",
		},

		vendors = {
			["qwenl"] = {
				__inherited_from = "ollama",
				endpoint = llamafile_endpoint,
				model = "qwen",
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
		}
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
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
