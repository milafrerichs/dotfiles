return {
	"rgroli/other.nvim",
	config = function()
		require("other-nvim").setup({
			mappings = {
				"rails",
				"golang",
				"python",
				"react",
				"rust",
				{
					pattern = "([^/]+)/(?:__tests__/)?([^/.]+)(?:\\.(?:test|spec))?\\.ts$",
					target = {
						{
							target = "%1/__tests__/%2.test.ts",
							context = "test",
						},
						{
							target = "%1/%2.ts",
							context = "implementation",
						},
					},
				},
			},
		})
	end,
}
