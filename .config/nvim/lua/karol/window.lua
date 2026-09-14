-- autocmd group for migrated vimrc settings
local group = vim.api.nvim_create_augroup("karol_window", { clear = true })

-- Highlight current line only in the active split.
vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave" }, {
  group = group,
  callback = function(args)
    vim.wo.cursorline = args.event == "WinEnter"
  end,
})