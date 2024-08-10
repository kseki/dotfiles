local lualine_setup, lualine = pcall(require, "lualine")
if not lualine_setup then
	return
end

local tabline_setup, tabline = pcall(require, "tabline")
if not tabline_setup then
	return
end

tabline.setup({
	enable = true,
	options = {
		show_tabs_always = true,
	},
})

lualine.setup({
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { tabline.tabline_buffers },
		lualine_x = { tabline.tabline_tabs },
		lualine_y = {},
		lualine_z = {},
	},
})

local augroup = vim.api.nvim_create_augroup("TablineBuffers", {})

function ShowCurrentBuffers()
	local data = vim.t.tabline_data
	if data == nil then
		tabline._new_tab_data(vim.fn.tabpagenr())
		data = vim.t.tabline_data
	end

	data.show_all_buffers = false
	vim.t.tabline_data = data
	vim.cmd([[redrawtabline]])
end

-- Show only buffers in current tab
vim.api.nvim_create_autocmd({ "TabEnter" }, {
	group = augroup,
	callback = ShowCurrentBuffers,
})
