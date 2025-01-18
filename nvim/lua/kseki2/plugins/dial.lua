return {
	"monaqa/dial.nvim",
	event = "BufRead",
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			-- default augends used when no group name is specified
			default = {
				augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
				augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
				augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
				augend.constant.alias.bool, -- boolean value (true <-> false)
			},
		})

		vim.keymap.set("n", "+", function()
			require("dial.map").manipulate("increment", "normal")
		end)
		vim.keymap.set("n", "-", function()
			require("dial.map").manipulate("decrement", "normal")
		end)
		vim.keymap.set("n", "g+", function()
			require("dial.map").manipulate("increment", "gnormal")
		end)
		vim.keymap.set("n", "g-", function()
			require("dial.map").manipulate("decrement", "gnormal")
		end)
		vim.keymap.set("v", "+", function()
			require("dial.map").manipulate("increment", "visual")
		end)
		vim.keymap.set("v", "-", function()
			require("dial.map").manipulate("decrement", "visual")
		end)
		vim.keymap.set("v", "g+", function()
			require("dial.map").manipulate("increment", "gvisual")
		end)
		vim.keymap.set("v", "g-", function()
			require("dial.map").manipulate("decrement", "gvisual")
		end)
	end,
}
