-- editor options, migrated from .vimrc
local opt = vim.opt

-- UI
opt.number = true      -- show absolute line numbers in the left gutter (nvim default: off)
opt.cursorline = true  -- highlight the line the cursor is on, in the current window (see WinEnter/WinLeave autocmds below) (nvim default: off)
opt.wildmode = { "longest", "full" }

-- Editing
-- opt.textwidth = 80     -- wrap column used by gq/gw and 'formatoptions' (long lines aren't hard-wrapped automatically, see wrap=false) (nvim default: 0)
opt.wrap = false       -- display long lines on one row, scrolling sideways, instead of soft-wrapping them (nvim default: on)

-- Text Control
opt.tabstop = 2        -- a literal <Tab> character is displayed as 2 columns wide (nvim default: 8)
opt.softtabstop = 2    -- <Tab>/<BS> insert/remove 2 columns worth of whitespace while editing (nvim default: 0)
opt.shiftwidth = 2     -- indent commands (>>, <<, autoindent) shift by 2 columns (nvim default: 8)
opt.expandtab = true   -- insert spaces instead of a literal <Tab> character (nvim default: off)

-- Other options
opt.backup = true      -- write a ~ backup copy next to the file before overwriting it, so edits can be recovered (nvim default: off)

-- Store saved views in Neovim's machine-local state directory
opt.viewdir = vim.fn.stdpath("state") .. "/view//"
opt.viewoptions:remove("options")

