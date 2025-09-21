local options = {
	number = true,
	autoindent = true,
	clipboard = "unnamedplus",
	
	-- tab behavior
	shiftwidth = 3,
  smartindent = true,
  undofile = true,
  showtabline = 1
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

