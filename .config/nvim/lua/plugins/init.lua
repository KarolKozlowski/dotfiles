-- lazy.nvim plugin specs, replacing the pathogen bundles from .vim/bundle
return {
  { "tpope/vim-fugitive" },

  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dracula")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },

  -- replaces syntastic; configure linters/formatters per filetype as needed
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost", -- lazy.nvim runs the autocmd below for us
    opts = {
      linters_by_ft = {
        python = { "flake8" },
      },
    },
    config = function(_, opts)
      require("lint").linters_by_ft = opts.linters_by_ft
      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
