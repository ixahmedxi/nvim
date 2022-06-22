local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = false,
		registers = false,
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			windows = false,
			nav = false,
			z = false,
			g = false,
		},
	},
}

local opts = {
	prefix = "<leader>",
}

local mappings = {
	e = { "<cmd>NvimTreeToggle<cr>", "Toggle Explorer" },
	r = { "<cmd>NvimTreeRefresh<cr>", "Refresh Explorer" },
	w = { "<cmd>w<cr>", "Save" },
	q = { "<cmd>Bdelete<cr>", "Close" },
	f = {
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Find files",
	},
	F = { "<cmd>Telescope live_grep<cr>", "Find Text" },
	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},
	h = {
		name = "Hop",
		h = { "<cmd>HopWordCurrentLine<cr>", "Current line" },
		w = { "<cmd>HopChar2<cr>", "2 Chars" },
		p = { "<cmd>HopPattern<cr>", "Pattern" },
	},
	t = {
		name = "Typescript",
		f = { "<cmd>lua require('typescript').actions.fixAll()<cr>", "Fix All" },
		r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
		u = { "<cmd>lua require('typescript').actions.removeUnused()<cr>", "Remove Unused" },
		o = { "<cmd>lua require('typescript').actions.oranizeImports()<cr>", "Organize Imports" },
		a = { "<cmd>lua require('typescript').actions.addMissingImports()<cr>", "Add Missing Imports" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)
