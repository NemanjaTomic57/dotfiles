return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				prettier = {
					command = "prettier",
					args = {
						"--stdin-filepath",
						"$FILENAME",
						"--tab-width",
						"2",
						"--use-tabs",
						"false",
					},
				},
				php_cs_fixer = {
					command = "php-cs-fixer",
					args = { "fix", "$FILENAME", "--quiet" },
					stdin = false,
					env = {
						PHP_CS_FIXER_IGNORE_ENV = "1",
					},
				},
			},
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				php = { "php_cs_fixer" },
				lua = { "stylua" },
				json = { "prettier" },

				yaml = { "prettier" },
				yml = { "prettier" },
				tf = { "prettier" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 10000,
			})
		end, { desc = " Prettier Format whole file or range (in visual mode) with" })
	end,
}
