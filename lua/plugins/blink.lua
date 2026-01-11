return {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "1.*",
    dependencies = {
        -- 'folke/lazydev.nvim',
        {
            "saghen/blink.compat",
            optional = true,
            opts = {},
            version = not vim.g.lazyvim_blink_main and "*",
        },
    },
    opts = {
        keymap = {
            preset = "enter",
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            -- providers = {
            --   lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
            -- },
        },
        fuzzy = { implementation = "lua" },
        signature = { enabled = true },
    },
}
