return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
		hints = { enabled = false },
		provider = "qwen",
		auto_suggestions_provider = "llama",
		vendors = {
    ---@type AvanteProvider
    ["llama"] = {
      endpoint = "127.0.0.1:11434",
      model = "llama3.2",
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 125000,
			api_key = "",
			parse_curl_args = function(opts, code_opts)
				 return {
					 url = opts.endpoint .. "/v1/chat/completions",
					 headers = {
						 ["Accept"] = "application/json",
						 ["Content-Type"] = "application/json",
					 },
					 body = {
						 model = opts.model,
						 messages = require("avante.providers").copilot.parse_messages(code_opts),
						 stream = true,
					 },
				 }
			 end,
			 parse_response_data = function(data_stream, event_state, opts)
				 require("avante.providers").openai.parse_response(data_stream, event_state, opts)
			 end,
		 },
    ---@type AvanteProvider
    ["qwen"] = {
      endpoint = "127.0.0.1:8888",
      model = "qwen",
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 8000,
			parse_curl_args = function(opts, code_opts)
				 return {
					 url = opts.endpoint .. "/v1/chat/completions",
					 headers = {
						 ["Accept"] = "application/json",
						 ["Content-Type"] = "application/json",
					 },
					 body = {
						 model = opts.model,
						 messages = require("avante.providers").copilot.parse_messages(code_opts),
						 max_tokens = 2048,
						 stream = true,
					 },
				 }
			 end,
			 parse_response_data = function(data_stream, event_state, opts)
				 require("avante.providers").openai.parse_response(data_stream, event_state, opts)
			 end,
		 },
    ["qwenl"] = {
      endpoint = "127.0.0.1:8080",
      model = "qwen",
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 8000,
			parse_curl_args = function(opts, code_opts)
				 return {
					 url = opts.endpoint .. "/v1/chat/completions",
					 headers = {
						 ["Accept"] = "application/json",
						 ["Content-Type"] = "application/json",
					 },
					 body = {
						 model = opts.model,
						 messages = require("avante.providers").copilot.parse_messages(code_opts),
						 max_tokens = 2048,
						 stream = true,
					 },
				 }
			 end,
			 parse_response_data = function(data_stream, event_state, opts)
				 require("avante.providers").openai.parse_response(data_stream, event_state, opts)
			 end,
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
