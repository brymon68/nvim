M = {}
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

-- check if value in table
local function contains(t, value)
  for _, v in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#20262c" })
vim.api.nvim_set_hl(0, "SLTermIcon", { fg = "#b668cd", bg = "#20262c" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#abb2bf", bg = "#20262c", bold = false })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#abb2bf", bg = "#20262c" })
vim.api.nvim_set_hl(0, "SLFG", { fg = "#abb2bf", bg = "#20262c" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#6b727f", bg = "#20262c" })
vim.api.nvim_set_hl(0, "SLLSP", { fg = "#5e81ac", bg = "#20262c" })
vim.api.nvim_set_hl(0, "SLError", { fg = "#abb2bf", bg = "#20262c" })
vim.api.nvim_set_hl(0, "SLWarning", { fg = "#abb2bf", bg = "#20262c" })
-- darkerplus
local mode_color = {
  n = "#519fdf",
  i = "#c18a56",
  v = "#b668cd",
  -- [""] = "#b668cd",
  V = "#b668cd",
  -- c = '#B5CEA8',
  -- c = '#D7BA7D',
  c = "#46a6b2",
  no = "#D16D9E",
  s = "#88b369",
  S = "#c18a56",
  [""] = "#c18a56",
  ic = "#d05c65",
  R = "#D16D9E",
  Rv = "#d05c65",
  cv = "#519fdf",
  ce = "#519fdf",
  r = "#d05c65",
  rm = "#46a6b2",
  ["r?"] = "#46a6b2",
  ["!"] = "#46a6b2",
  t = "#d05c65",
}

local mode = {
  -- mode component
  function()
    return "  "
  end,
  color = function()
    -- auto change color according to neovims mode
    return { bg = mode_color[vim.fn.mode()] }
  end,
  padding = 0,
}

local hide_in_width_60 = function()
  return vim.o.columns > 60
end

local hide_in_width = function()
  return vim.o.columns > 80
end

local hide_in_width_100 = function()
  return vim.o.columns > 100
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = true,
  update_in_insert = false,
  always_visible = true,
  color = { bg = "#20262c" },
  cond = hide_in_width,
  separator = "%#SLSeparator#" .. " │" .. "%*",

}

local diff = {
  "diff",
  colored = true,
  symbols = { added = "", modified = "", removed = "" }, -- changes diff symbols
  cond = hide_in_width_60,
  separator = "%#SLSeparator#" .. "│ " .. "%*",
}


local filename = {
  "filename",
  colored = true,
  color = { bg = "#20262c" }
}

local filetype = {
  "filetype",
  fmt = function(str)
    local ui_filetypes = {
      "help",
      "packer",
      "neogitstatus",
      "NvimTree",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
    }

    if str == "toggleterm" then
      -- 
      local term = "%#SLTermIcon#"
          .. " "
          .. "%*"
          .. "%#SLFG#"
          .. vim.api.nvim_buf_get_var(0, "toggle_number")
          .. "%*"
      return term
    end

    if contains(ui_filetypes, str) then
      return ""
    else
      return str
    end
  end,
  icons_enabled = true,
}

-- local branch = {
--   "branch",
--   icons_enabled = true,
--   icon = "%#SLGitIcon#" .. "" .. "%*" .. "%#SLBranchName#",
--   -- color = "Constant",
--   colored = false,
-- }

-- local progress = {
--   "progress",
--   color = "SLProgress",
-- }

local current_signature = {
  function()
    local buf_ft = vim.bo.filetype

    if buf_ft == "toggleterm" then
      return ""
    end
    if not pcall(require, "lsp_signature") then
      return ""
    end
    local sig = require("lsp_signature").status_line(30)
    local hint = sig.hint

    if not require("user.functions").isempty(hint) then
      -- return "%#SLSeparator#│ : " .. hint .. "%*"
      return "%#SLSeparator#│ " .. hint .. "%*"
    end

    return ""
  end,
  cond = hide_in_width_100,
  padding = 0,
}

local spaces = {
  function()
    local buf_ft = vim.bo.filetype

    local ui_filetypes = {
      "help",
      "packer",
      "neogitstatus",
      "NvimTree",
      "lir",
      "Outline",
      "spectre_panel",
      "DressingSelect",
      "",
    }
    local space = ""

    if contains(ui_filetypes, buf_ft) then
      space = " "
    end

    -- TODO: update codicons and use their indent
    return "  " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. space
  end,
  padding = 0,
  separator = "%#SLSeparator#" .. " │" .. "%*",
  cond = hide_in_width_100,
}

local lanuage_server = {
  function()
    local buf_ft = vim.bo.filetype
    local ui_filetypes = {
      "help",
      "packer",
      "neogitstatus",
      "NvimTree",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "",
    }

    if contains(ui_filetypes, buf_ft) then
      return M.language_servers
    end

    local clients = vim.lsp.buf_get_clients()
    local client_names = {}
    local copilot_active = false

    -- add formatter
    local s = require("null-ls.sources")
    local available_sources = s.get_available(buf_ft)
    local registered = {}
    for _, source in ipairs(available_sources) do
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        table.insert(registered[method], source.name)
      end
    end

    local formatter = registered["NULL_LS_FORMATTING"]
    local linter = registered["NULL_LS_DIAGNOSTICS"]
    if formatter ~= nil then
      vim.list_extend(client_names, formatter)
    end
    if linter ~= nil then
      vim.list_extend(client_names, linter)
    end

    -- join client names with commas
    local client_names_str = table.concat(client_names, ", ")

    -- check client_names_str if empty
    local language_servers = ""
    local client_names_str_len = #client_names_str
    if client_names_str_len ~= 0 then
      language_servers = "%#SLLSP#" .. "[" .. client_names_str .. "]" .. "%*"
    end

    if client_names_str_len == 0 and not copilot_active then
      return ""
    else
      M.language_servers = language_servers
      return language_servers
    end
  end,
  padding = 0,
  cond = hide_in_width,
  separator = "%#SLSeparator#" .. " │" .. "%*",
}

lualine.setup({
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "catppuccin",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { diagnostics },
    lualine_c = { diff },
    lualine_x = { lanuage_server, spaces, filetype },
    lualine_y = { filename },
    lualine_z = { "os.date('%a')", "data", "require'lsp-status'.status()" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
