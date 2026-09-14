-- save/restore view (folds, cursor position, ...) per file

local group = vim.api.nvim_create_augroup("karol_views", { clear = true })

-- Save/restore cursor position, folds, and selected per-file state.
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = group,
  callback = function()
    if vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! mkview")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  callback = function()
    if vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! loadview")
    end
  end,
})