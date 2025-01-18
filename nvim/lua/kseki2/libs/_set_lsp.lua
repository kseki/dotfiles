local M = {}

local fmt = string.format
local default_config = require("kseki2.lsp.default")

function M.conf_lsp(name)
	local ok, _ = pcall(require, fmt("lsp.%s", name))

	if not ok then
		default_config(name)
	end
end

return M
