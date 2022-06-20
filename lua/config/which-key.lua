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
    }
  }
}

local opts = {
  prefix = "<leader>",
}

local mappings = {
  e = { "<cmd>NvimTreeToggle<cr>", "Toggle Explorer" },
  r = { "<cmd>NvimTreeRefresh<cr>", "Refresh Explorer" },
  w = { "<cmd>w<cr>", "Save" },
  q = { "<cmd>Bdelete<cr>", "Close" },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
