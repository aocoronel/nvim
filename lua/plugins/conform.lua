return {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    ft = { "lua", "shell", "python", "json", "html", "css", "markdown", "rust", "toml" },
    event = { "BufWritePre" },
    keys = {
        {
            "<leader>cf",
            function() require("conform").format { async = true, lsp_format = "fallback" } end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    enabled = true,
    lazy = true,
    opts = function()
        local opts = {
            notify_on_error = false,
            default_format_opts = {
                timeout_ms = 3000,
                async = false,
                quiet = false,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                bash = { "shfmt" },
                c = { "clang-format" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier" },
                python = { "black" },
                rust = { "rustfmt" },
                sh = { "shfmt" },
                toml = { "taplo" },
                zsh = { "shfmt" },
            },
            formatters = {
                injected = { options = { ignore_errors = true } },
            },
        }
        return opts
    end,
}
