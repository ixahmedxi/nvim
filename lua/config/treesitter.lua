local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

treesitter.setup({
	ensure_installed = {
		"lua",
		"html",
		"css",
		"javascript",
		"json",
		"yaml",
		"toml",
		"typescript",
		"tsx",
		"svelte",
		"vue",
		"astro",
		"prisma",
		"scss",
		"pug",
		"dockerfile",
		"graphql",
		"markdown",
	},
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})
