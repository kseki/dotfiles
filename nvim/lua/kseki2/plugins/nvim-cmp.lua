return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"f3fora/cmp-spell",
		"onsails/lspkind.nvim",
		{
			"zbirenbaum/copilot-cmp",
			dependencies = {
				"zbirenbaum/copilot.lua",
				opts = {
					suggestion = { enabled = false },
					panel = { enabled = false },
				},
			},
		},
	},
	config = function()
		-- for spell
		vim.opt.spell = true
		vim.opt.spelllang = { "en_us" }
		-- for copilot
		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local copilot_cmp = require("copilot_cmp")

		copilot_cmp.setup({
			fix_pairs = true,
		})

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lsp" },
				{
					name = "spell",
					option = {
						keep_all_entries = false,
						enable_in_context = function()
							return true
						end,
						preselect_correct_word = true,
					},
				},
				{ name = "buffer" },
				{ name = "path" },
			}),
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = {
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- menu = function() return math.floor(0.45 * vim.o.columns) end,
						menu = 100, -- leading text (labelDetails)
						abbr = 50, -- actual suggestion item
					},
					symbol_map = { Copilot = "" },
				}),
			},
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = {
				disallow_fuzzy_matching = true,
				disallow_fullfuzzy_matching = true,
				disallow_partial_matching = true,
				disallow_partial_fuzzy_matching = true,
				disallow_prefix_unmatching = true,
				disallow_symbol_nonprefix_matching = false,
			},
		})
	end,
}
