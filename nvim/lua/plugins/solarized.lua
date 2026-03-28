return {
	"maxmx03/solarized.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("solarized").setup({
			on_highlights = function(colors, color)
				local darken = color.darken
				local lighten = color.lighten
				local blend = color.blend
				local shade = color.shade
				local tint = color.tint

				---@type solarized.highlights
				local groups = {
					--Visual = { bg = colors.base02, standout = true },
					--Function = { fg = colors.yellow },
					--IncSearch = { fg = colors.orange, bg = colors.mix_orange },
					--Search = { fg = colors.violet, bg = shade(colors.violet, 5) },
					--NormalFloat = { bg = darken(colors.base03, 25) }
					NeotestAdapterName = { fg = colors.violet, bold = true },
					NeotestFile = { fg = colors.violet, bold = true },
					NeotestDir = { fg = colors.violet, bold = true },
					NeotestWatching = { fg = colors.violet, bold = true },
					--NeotestFocused = { bold = true },
					--NeotestNamespace = { fg = "${blue}", bold = true },
					NeotestPassed = { fg = darken(colors.green, 25), standout = true },
					NeotestRunning = { fg = lighten(colors.orange, 50) },
					NeotestFailed = { fg = darken(colors.red, 25), standout = true },
					-- AvanteSuggestion = { bg = darken(color.red, 25) },
				}

				return groups
			end,
		})
		vim.o.background = "light"
		vim.cmd.colorscheme("solarized")
	end,
}
