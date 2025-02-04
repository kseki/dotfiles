return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
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
					filetypes = {
						yaml = true,
						markdown = true,
						help = false,
						gitcommit = false,
						gitrebase = false,
						hgcommit = false,
						svn = false,
						cvs = false,
						["."] = false,
					},
				},
			},
		},
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "v2.*",
			build = "make install_jsregexp",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_lua").load({ path = { "~/dotfiles/.config/nvim/luasnippet" } })
				vim.keymap.set(
					"n",
					"<leader>ss",
					require("luasnip.loaders").edit_snippet_files,
					{ desc = "Edit snippets" }
				)
			end,
		},
		{ "saadparwaiz1/cmp_luasnip" },
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
		local luasnip = require("luasnip")

		copilot_cmp.setup({
			fix_pairs = true,
		})

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert,noselect",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end,
				["<C-n>"] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end,
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-k>"] = cmp.mapping(function(fallback)
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "luasnip", option = { use_show_condition = false } },
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
			}),
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = {
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- menu = function() return math.floor(0.45 * vim.o.columns) end,
						menu = 200, -- leading text (labelDetails)
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
