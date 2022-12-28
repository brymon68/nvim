local status_ok, symbols_outline = pcall(require, "symbols-outline")
if not status_ok then
	print("ayy")
	return
end

-- local icons = require("user.icons")

local opts = {
	highlight_hovered_item = true,
	show_guides = true,
	auto_preview = false,
	position = "right",
	width = 40,
	show_numbers = false,
	show_relative_numbers = false,
	show_symbol_details = true,
	keymaps = { -- These keymaps can be a string or a table for multiple keys
		close = { "<Esc>", "q" },
		goto_location = "<Cr>",
		focus_location = "o",
		hover_symbol = "<C-space>",
		toggle_preview = "K",
		rename_symbol = "r",
		code_actions = "a",
	},
	lsp_blacklist = {},
	symbol_blacklist = {},
	symbols = {
		File = { icon = "", hl = "CmpItmeKindFile" },
		Module = { icon = "", hl = "CmpItemKindModule" },
		Namespace = { icon = "", hl = "CmptItemKindModule" },
		Package = { icon = "", hl = "CmpItemKindModule" },
		Class = { icon = "𝓒", hl = "CmpItemKindClass" },
		Method = { icon = "ƒ", hl = "CmptItemKindMethod" },
		Property = { icon = "", hl = "CmptItemKindProperty" },
		Field = { icon = "", hl = "CmpItemKindField" },
		Constructor = { icon = "", hl = "CmptItemKindConstructor" },
		Enum = { icon = "ℰ", hl = "CmpItemKindEnum" },
		Interface = { icon = "ﰮ", hl = "CmpItemKindInterface" },
		Function = { icon = "", hl = "CmpItemKindFunction" },
		Variable = { icon = "", hl = "CmpItemKindVariable" },
		Constant = { icon = "", hl = "CmpItemKindConstant" },
		String = { icon = "𝓐", hl = "TSString" },
		Number = { icon = "#", hl = "TSNumber" },
		Boolean = { icon = "⊨", hl = "TSBoolean" },
		Array = { icon = "", hl = "TSKeyword" },
		Object = { icon = "⦿", hl = "TSKeyword" },
		Key = { icon = "🔐", hl = "CmpItemKeyword" },
		Null = { icon = "NULL", hl = "TSType" },
		EnumMember = { icon = "", hl = "TSField" },
		Struct = { icon = "𝓢", hl = "TSType" },
		Event = { icon = "🗲", hl = "TSType" },
		Operator = { icon = "+", hl = "CmpItemKindOperator" },
		TypeParameter = { icon = "𝙏", hl = "TSParameter" },
	},
}

symbols_outline.setup(opts)
