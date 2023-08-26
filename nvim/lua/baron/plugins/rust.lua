local setup, rust = pcall(require, "rust")
if not setup then
	return
end

rust.setup({
	ft = "rust",
})

vim.g.rustfmt_autosave = 1
