local M = {}

M.setup = function()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
			-- width = 40,
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
		width = 60,
		-- height = 30,
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		width = 60,
		-- height = 30,
	})
end

local function lsp_highlight_document(client)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
	-- end
end

local function attach_navic(client, bufnr)
	vim.g.navic_silence = true
	local status_ok, navic = pcall(require, "nvim-navic")
	if not status_ok then
		return
	end
	navic.attach(client, bufnr)
end

function M.define_augroups(definitions, buffer)
	for group_name, definition in pairs(definitions) do
		vim.cmd("augroup " .. group_name)
		if buffer then
			vim.cmd([[autocmd! * <buffer>]])
		else
			vim.cmd([[autocmd!]])
		end

		for _, def in pairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.cmd(command)
		end

		vim.cmd("augroup END")
	end
end

function M.enable_format_on_save()
	local fmd_cmd = string.format(":silent lua vim.lsp.buf.formatting_sync({}, %s)", 1000)

	M.define_augroups({
		format_on_save = { { "BufWritePre", "*", fmd_cmd } },
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	M.capabilities = vim.lsp.protocol.make_client_capabilities()

	local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if not status_cmp_ok then
		return
	end

	M.capabilities.textDocument.completion.completionItem.snippetSupport = true
	M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

	if client.name == "sumneko_lua" then
		client.resolved_capabilities.document_formatting = false
	end

	M.enable_format_on_save()
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
	attach_navic(client, bufnr)
end

return M
