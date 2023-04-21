local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	highlight = { enable = true },
	endwise = { enable = true },
	indent = { enable = true },
	autotag = { enable = true },
	ensure_installed = {
		"json",
		"javascript",
		"typescript",
		"tsx",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"svelte",
		"graphql",
		"ruby",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
	},
	auto_install = true,

	-- nvim-ts-autotag
	autotag = { enable = true },

	-- nvim-treesitter-endwise
	endwise = { enable = true },

	--nvim-treesitter-textobjects
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
				["ae"] = "@block.outer",
				["ie"] = "@block.inner",
				["is"] = "@statement.inner",
				["as"] = "@statement.outer",
				["ad"] = "@comment.outer",
				["am"] = "@call.outer",
				["im"] = "@call.inner",
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			include_surrounding_whitespace = false,
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},

	-- nvim-treesitter-textsubjects
	textsubjects = {
		enable = true,
		prev_selection = ",", -- (Optional) keymap to select the previous selection
		keymaps = {
			["."] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer",
			["i;"] = "textsubjects-container-inner",
		},
	},
})
