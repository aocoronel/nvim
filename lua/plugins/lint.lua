return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require "lint"

        lint.linters_by_ft = {
            c = { "clangtidy" },
        }

        lint.linters_by_ft["clojure"] = nil
        lint.linters_by_ft["dockerfile"] = nil
        lint.linters_by_ft["inko"] = nil
        lint.linters_by_ft["janet"] = nil
        lint.linters_by_ft["json"] = nil
        lint.linters_by_ft["markdown"] = nil
        lint.linters_by_ft["rst"] = nil
        lint.linters_by_ft["ruby"] = nil
        lint.linters_by_ft["terraform"] = nil
        lint.linters_by_ft["text"] = nil

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function() require("lint").try_lint() end,
        })
    end,
}
