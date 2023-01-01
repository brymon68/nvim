local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup({
	debug = true,
	sources = {
		formatting.eslint.with({
			args = { "src/", "--ext", ".js,.jsx", "--fix" },
		}),
		formatting.prettier.with({
			extra_filetypes = { "toml", "json", "tsx", "tsx", "jsx", "js" },
		}),
		formatting.black.with({ extra_args = { "--line-length", "79" } }),
		formatting.stylua,
		diagnostics.flake8,
	},
})
