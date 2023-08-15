local kind = require("user.kind")

lvim.leader = "space"

lvim.keys.insert_mode["jk"] = "<Esc>"
lvim.keys.normal_mode["<C-s>"] = ":wa<cr>"
lvim.keys.normal_mode["<C-q>"] = ":MyClose<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<leader>-"] = ":split<cr>"
lvim.keys.normal_mode["<leader>\\"] = ":vsplit<cr>"
vim.keymap.set('n', 'gn', ":tabe %<CR>")

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.lsp.buffer_mappings.normal_mode["gr"] = {
  ":lua require'telescope.builtin'.lsp_references()<cr>",
  kind.cmp_kind.Reference .. " Find references"
}

lvim.lsp.buffer_mappings.normal_mode["gd"] = {
  ":lua vim.lsp.buf.definition()<cr>",
  -- ":lua require'telescope.builtin'.lsp_definitions()<cr>",
  kind.cmp_kind.Reference .. " Definitions"
}

lvim.lsp.buffer_mappings.normal_mode["gD"] = {
  ":lua vim.lsp.buf.type_definition()<cr>",
  kind.cmp_kind.Reference .. " Type Definition"
}

lvim.lsp.buffer_mappings.normal_mode["gf"] = {
  ":Telescope frecency<cr>",
  kind.cmp_kind.Reference .. " Telescope Frecency"
}
