local status_ok, browse = pcall(require, "browse")
if not status_ok then
  return
end
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "gp", ":lua require('peek').Peek('definition')<CR>", opts)
