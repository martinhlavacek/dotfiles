
lvim.plugins = {
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
    },
    { "lukas-reineke/indent-blankline.nvim" },
    {
        "nvim-treesitter/nvim-treesitter-angular"
    }
}
require("indent_blankline").setup {
  show_end_of_line = true,
}
