vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { ".config/lvim/config.lua" },
    command = "PackerCompile",
})

vim.api.nvim_create_user_command("MyClose", function()
    if require("nvim-tree.view").is_visible() then
        vim.cmd("NvimTreeClose")
    end
    vim.cmd("bdelete")
    vim.cmd("q")
end, { desc = "Close buer and NvimTree if open" })
