return {
    "nanotee/zoxide.vim",
    cmd = { "Zd", "Z" },
    config = function()
        vim.api.nvim_create_user_command("Zd", function(opts)
            vim.cmd("Z " .. opts.args)

            vim.cmd "edit ."
        end, {
            nargs = "*",
            complete = "file",
        })
    end,
}
