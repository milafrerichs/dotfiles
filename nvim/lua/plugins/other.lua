return {
	'rgroli/other.nvim',
	config = function()
		require("other-nvim").setup({
			mappings = {
						"angular",
						"rails",
						"golang",
						"python",
						"react",
						"rust",
						{
								pattern = "/(.*)/(.*)/.*.ts$",
								target = {
                {
                    target = "/%1/%2/%2.component.html",
                    context = "html"
                },
                {
                    target = "/%1/%2/%2.component.spec.ts",
                    context = "test"
                },
                {
                    target = "/%1/%2/%2.service.spec.ts",
                    context = "test"
                }
            }
						}
				},
		})
	end
}
