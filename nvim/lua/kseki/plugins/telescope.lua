local nvim_echo = vim.api.nvim_echo

local telescop_setup, telescope = pcall(require, "telescope")
if not telescop_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

local alternate_settings = {
	presets = { "rails", "rspec", "nestjs" },
}

local has_local_mappings, local_mappings = pcall(require, "telescope-alternate-mappings")
if has_local_mappings then
	nvim_echo({ { "[telescope-alternate]Local mappings found!" } }, true, {})
	alternate_settings.mappings = local_mappings.mappings
	alternate_settings.presets = {}
else
	nvim_echo({ { "[telescope-alternate]Local mappings not found!", "WarningMsg" } }, true, {})
end

telescope.setup({
	defualts = {
		color_devicons = true,
		mappings = {
			i = {
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<esc>"] = actions.close,
			},
			n = {
				["<esc>"] = actions.close,
			},
			file_ignore_patterns = {
				".git",
				"node_modules",
				"vendor/bundle",
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case",
		},
		["telescope-alternate"] = alternate_settings,
	},
})

telescope.load_extension("fzf")
telescope.load_extension("telescope-alternate")

-- autocmd User TelescopePreviewerLoaded setlocal wrap
vim.cmd([[
  autocmd User TelescopePreviewerLoaded setlocal wrap
]])

vim.cmd([[
  highlight TelescopeNormal guibg=#232831
  highlight TelescopeBorder guifg=#abb1bb
]])
