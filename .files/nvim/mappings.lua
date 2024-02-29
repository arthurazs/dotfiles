local M = {}

M.general = {
  n = {
    ["<leader>gg"] = { ":LazyGit<CR>", "LazyGit" },
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

return M
