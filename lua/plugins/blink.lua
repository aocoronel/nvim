return {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "1.*",
    opts = {
        keymap = {
            preset = 'none',
            ['<CR>'] = { 'accept', 'fallback' },
            ['<M-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<M-n>'] = { 'select_next', 'fallback_to_mappings' },
            ['<M-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<M-f>'] = { 'scroll_documentation_down', 'fallback' },
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = { implementation = "lua" },
        signature = { enabled = true },
    },
}
