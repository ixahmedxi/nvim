local lsp_keymaps = require("config.lsp.keymaps")
local servers = {
	"astro",
	"cssls",
	"cssmodules_ls",
	"dockerls",
	"emmet_ls",
	"graphql",
	"html",
	"jsonls",
	"tsserver",
	"sumneko_lua",
	"marksman",
	"prismals",
	"svelte",
	"tailwindcss",
	"volar",
	"yamlls",
}

-- Auto install lsp servers
require("nvim-lsp-installer").setup({
	ensure_installed = servers,
})

-- Initialise cmp lsp autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lspconfig = require("lspconfig")

-- Lsp diagnostics ui customisation
local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	virtual_text = false,
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

-- Default lsp options
local opts = {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		if client.name == "tsserver" then
			client.server_capabilities.document_formatting = false
		end

		lsp_keymaps(bufnr)
	end,
}

-- Looping all servers and setting them up
for _, server in ipairs(servers) do
	-- If a server has custom settings (lua, json) include it in the options
	local has_custom_opts, custom_opts = pcall(require, "config.lsp.settings." .. server)

	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", custom_opts, opts)
	end

	-- Typescript lsp server setup
	if server == "tsserver" then
		require("typescript").setup({
			disable_commands = false,
			debug = false,
			server = opts,
		})
	else
		-- Any other lsp server
		lspconfig[server].setup(opts)
	end
end

require('config.lsp.null-ls')
