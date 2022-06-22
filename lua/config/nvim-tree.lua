local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback
vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			vim.cmd("quit")
		end
	end,
})

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	ignore_ft_on_setup = { "alpha" },
	diagnostics = {
		enable = true,
	},
	update_focused_file = {
		enable = true,
	},
	git = {
		enable = true,
	},
	filters = {
		custom = { ".git" },
	},
	view = {
		width = 35,
		hide_root_folder = true,
		mappings = {
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("split") },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
	},
	renderer = {
		highlight_git = true,
		icons = {
			webdev_colors = true,
			git_placement = "signcolumn",
			show = {
				git = false,
			},
		},
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "package.json" },
	},
	trash = {
		require_confirm = false,
	},
	actions = {
		change_dir = {
			enable = false,
		},
	},
})
