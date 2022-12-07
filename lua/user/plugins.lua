local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")

	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("akinsho/bufferline.nvim")
	use("famiu/bufdelete.nvim")
	use("numToStr/Comment.nvim")
	use("goolord/alpha-nvim")
	use("folke/which-key.nvim")
	use("kyazdani42/nvim-tree.lua")
	use("nvim-lua/popup.nvim")
	use("christianchiarulli/lualine.nvim")
	use("akinsho/toggleterm.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("kylechui/nvim-surround")
	use({
		"abecodes/tabout.nvim",
		wants = { "nvim-treesitter" }, -- or require if not used so far
	})
	use("NvChad/nvim-colorizer.lua")
	use("windwp/nvim-spectre")
	use("kevinhwang91/nvim-bqf")
	use("MattesGroeger/vim-bookmarks")

	-- -- UI
	use("ghillb/cybu.nvim")
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	--

	use("rcarriga/nvim-notify")
	use("kyazdani42/nvim-web-devicons")
	use("karb94/neoscroll.nvim")
	use("folke/todo-comments.nvim")
	use("andymass/vim-matchup")

	-- Colorschemes
	use("folke/tokyonight.nvim")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})
	use("rebelot/kanagawa.nvim")

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp" })
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-emoji")
	use("hrsh7th/cmp-nvim-lua")
	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	--
	-- -- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("RRethy/vim-illuminate")
	use("j-hui/fidget.nvim")
	use("LunarVim/peek.lua")

	use("ray-x/lsp_signature.nvim")
	-- cutlass
	use({
		"gbprod/cutlass.nvim",
	})
	-- Typescript TODO: set this up, also add keybinds to ftplugin
	use("jose-elias-alvarez/typescript.nvim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("tom-anders/telescope-vim-bookmarks.nvim")
	use("nvim-telescope/telescope-media-files.nvim")
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")
	-- -- Git
	use("lewis6991/gitsigns.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
