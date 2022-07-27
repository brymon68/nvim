local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[                              __ __       __     ]],
  [[         __                  _\ \\ \__   /' \    ]],
  [[ __  __ /\_\    ___ ___     /\__  _  _\ /\_, \   ]],
  [[/\ \/\ \\/\ \ /' __` __`\   \/_L\ \\ \L \/_/\ \  ]],
  [[\ \ \_/ |\ \ \/\ \/\ \/\ \    /\_   _  \   \ \ \ ]],
  [[ \ \___/  \ \_\ \_\ \_\ \_\   \/_/\_\\_/    \ \_\]],
  [[  \/__/    \/_/\/_/\/_/\/_/      \/_//_/     \/_/]],
}

dashboard.section.buttons.val = {
   dashboard.button(
    "p",
    "  Recent projects",
    ":lua require('telescope').extensions.projects.projects()<CR>"
  ),
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("t", "  Search text", ":Telescope live_grep <CR>"),
  dashboard.button("r", "  Find recent file", ":Telescope oldfiles <CR>"),
  dashboard.button("e", "  Edit Configuration", "<cmd>lua require('user.telescope').edit_neovim()<CR>"),
  dashboard.button("u", "  PackerSync", ":PackerSync<CR>"),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}
local function footer()
  return "brycesec@amazon.com"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
