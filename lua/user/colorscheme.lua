local colorscheme = "catppuccin"
-- vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	-- vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

require("catppuccin").setup({
	flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
	background = { light = "latte", dark = "mocha" },
	dim_inactive = {
		enabled = false,
		-- Dim inactive splits/windows/buffers.
		-- NOT recommended if you use old palette (a.k.a., mocha).
		shade = "dark",
		percentage = 0.15,
	},
	transparent_background = false,
	term_colors = true,
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
	styles = {
		comments = { "italic" },
		properties = { "italic" },
		functions = { "italic", "bold" },
		keywords = { "italic" },
		operators = { "bold" },
		conditionals = { "bold" },
		loops = { "bold" },
		booleans = { "bold", "italic" },
		numbers = {},
		types = {},
		strings = {},
		variables = {},
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		lsp_trouble = true,
		lsp_saga = true,
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		nvimtree = true,
		which_key = true,
		indent_blankline = { enabled = true, colored_indent_levels = false },
		dashboard = true,
		neogit = false,
		vim_sneak = false,
		fern = false,
		barbar = false,
		markdown = true,
		lightspeed = false,
		ts_rainbow = true,
		mason = true,
		neotest = false,
		noice = false,
		hop = true,
		illuminate = true,
		cmp = true,
		dap = { enabled = true, enable_ui = true },
		notify = true,
		symbols_outline = false,
		coc_nvim = false,
		leap = false,
		neotree = { enabled = false, show_root = true, transparent_panel = false },
		telekasten = false,
		mini = false,
		aerial = false,
		vimwiki = true,
		beacon = false,
		navic = { enabled = false },
		overseer = false,
		fidget = true,
	},
	color_overrides = {
		mocha = {

			rosewater = "#F5E0DC",
			flamingo = "#F2CDCD",
			pink = "#F5C2E7",
			mauve = "#CBA6F7",
			red = "#F38BA8",
			maroon = "#EBA0AC",
			peach = "#FAB387",
			yellow = "#F9E2AF",
			green = "#A6E3A1",
			teal = "#94E2D5",
			sky = "#89DCEB",
			sapphire = "#74C7EC",
			blue = "#89B4FA",
			lavender = "#B4BEFE",

			text = "#D9E0EE",
			subtext1 = "#BAC2DE",
			subtext0 = "#A6ADC8",
			overlay2 = "#C3BAC6",
			overlay1 = "#988BA2",
			overlay0 = "#6E6C7E",
			surface2 = "#6E6C7E",
			surface1 = "#575268",
			surface0 = "#302D41",

			base = "#20262c",
			mantle = "#20262c",
			crust = "#20262c",
		},
	},
	highlight_overrides = {
		mocha = function(cp)
			return {
				-- For base configs.
				CursorLineNr = { fg = cp.green },
				Search = { bg = cp.surface1, fg = cp.pink, style = { "bold" } },
				IncSearch = { bg = cp.pink, fg = cp.surface1 },

				-- For native lsp configs.
				DiagnosticVirtualTextError = { bg = cp.none },
				DiagnosticVirtualTextWarn = { bg = cp.none },
				DiagnosticVirtualTextInfo = { bg = cp.none },
				DiagnosticVirtualTextHint = { fg = cp.rosewater, bg = cp.none },

				DiagnosticHint = { fg = cp.rosewater },
				LspDiagnosticsDefaultHint = { fg = cp.rosewater },
				LspDiagnosticsHint = { fg = cp.rosewater },
				LspDiagnosticsVirtualTextHint = { fg = cp.rosewater },
				LspDiagnosticsUnderlineHint = { sp = cp.rosewater },

				-- For fidget.
				FidgetTask = { bg = cp.none, fg = cp.surface2 },
				FidgetTitle = { fg = cp.blue, style = { "bold" } },

				-- For treesitter.
				["@field"] = { fg = cp.rosewater },
				["@property"] = { fg = cp.yellow },

				["@include"] = { fg = cp.teal },
				["@operator"] = { fg = cp.sky },
				["@keyword.operator"] = { fg = cp.sky },
				["@punctuation.special"] = { fg = cp.maroon },

				-- ["@float"] = { fg = cp.peach },
				-- ["@number"] = { fg = cp.peach },
				-- ["@boolean"] = { fg = cp.peach },

				["@constructor"] = { fg = cp.lavender },
				-- ["@constant"] = { fg = cp.peach },
				-- ["@conditional"] = { fg = cp.mauve },
				-- ["@repeat"] = { fg = cp.mauve },
				["@exception"] = { fg = cp.peach },

				["@constant.builtin"] = { fg = cp.lavender },
				-- ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
				-- ["@type.builtin"] = { fg = cp.yellow, style = { "italic" } },
				["@variable.builtin"] = { fg = cp.red, style = { "italic" } },

				-- ["@function"] = { fg = cp.blue },
				["@function.macro"] = { fg = cp.red, style = {} },
				["@parameter"] = { fg = cp.rosewater },
				["@keyword.function"] = { fg = cp.maroon },
				["@keyword"] = { fg = cp.red },
				["@keyword.return"] = { fg = cp.pink, style = {} },

				-- ["@text.note"] = { fg = cp.base, bg = cp.blue },
				-- ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
				-- ["@text.danger"] = { fg = cp.base, bg = cp.red },
				-- ["@constant.macro"] = { fg = cp.mauve },

				-- ["@label"] = { fg = cp.blue },
				["@method"] = { style = { "italic" } },
				["@namespace"] = { fg = cp.rosewater, style = {} },

				["@punctuation.delimiter"] = { fg = cp.teal },
				["@punctuation.bracket"] = { fg = cp.overlay2 },
				-- ["@string"] = { fg = cp.green },
				-- ["@string.regex"] = { fg = cp.peach },
				-- ["@type"] = { fg = cp.yellow },
				["@variable"] = { fg = cp.text },
				["@tag.attribute"] = { fg = cp.mauve, style = { "italic" } },
				["@tag"] = { fg = cp.peach },
				["@tag.delimiter"] = { fg = cp.maroon },
				["@text"] = { fg = cp.text },

				-- ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
				-- ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
				-- ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
				-- ["@text.title"] = { fg = cp.blue, style = { "bold" } },
				-- ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
				-- ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
				-- ["@string.escape"] = { fg = cp.pink },

				-- ["@property.toml"] = { fg = cp.blue },
				-- ["@field.yaml"] = { fg = cp.blue },

				-- ["@label.json"] = { fg = cp.blue },

				["@function.builtin.bash"] = { fg = cp.red, style = { "italic" } },
				["@parameter.bash"] = { fg = cp.yellow, style = { "italic" } },

				["@field.lua"] = { fg = cp.lavender },
				["@constructor.lua"] = { fg = cp.flamingo },

				["@constant.java"] = { fg = cp.teal },

				["@property.typescript"] = { fg = cp.lavender, style = { "italic" } },
				-- ["@constructor.typescript"] = { fg = cp.lavender },

				-- ["@constructor.tsx"] = { fg = cp.lavender },
				-- ["@tag.attribute.tsx"] = { fg = cp.mauve },

				["@type.css"] = { fg = cp.lavender },
				["@property.css"] = { fg = cp.yellow, style = { "italic" } },

				["@property.cpp"] = { fg = cp.text },

				-- ["@symbol"] = { fg = cp.flamingo },
			}
		end,
	},
})

-- require("onedark").setup({
-- 	-- Main options --
-- 	style = "deep", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
-- 	transparent = false, -- Show/hide background
-- 	term_colors = true, -- Change terminal color as per the selected theme style
-- 	ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
-- 	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--
-- 	-- toggle theme style ---
-- 	toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
-- 	toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
--
-- 	-- Change code style ---
-- 	-- Options are italic, bold, underline, none
-- 	-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
-- 	code_style = {
-- 		comments = "italic",
-- 		keywords = "none",
-- 		functions = "none",
-- 		strings = "none",
-- 		variables = "none",
-- 	},
--
-- 	-- Lualine options --
-- 	lualine = {
-- 		transparent = true, -- lualine center bar transparency
-- 	},
--
-- 	-- Custom Highlights --
-- 	colors = {
-- 		bg = "#20262c",
-- 		bg0 = "#20262c",
-- 		bg1 = "#20262c",
-- 		bg_d = "#20262c",
-- 	}, -- Override default colors
-- 	highlights = {
-- 		["@constructor"] = { fg = "$light_grey" },
-- 		["@namespace"] = { fg = "$light_grey" },
-- 		["@constant"] = { fg = "$light_grey" },
-- 	}, -- Override highlight groups
--
-- 	-- Plugins Config --
-- 	diagnostics = {
-- 		darker = true, -- darker colors for diagnostic
-- 		undercurl = true, -- use undercurl instead of underline for diagnostics
-- 		background = true, -- use background color for virtual text
-- 	},
-- })
-- require("onedark").load()
