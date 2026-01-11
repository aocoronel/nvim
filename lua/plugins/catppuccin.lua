local elegantvagrant = {
    rosewater = "#f5e0dc",
    flamingo = "#f2cdcd",
    pink = "#f067fc",
    mauve = "#cba6f7",
    red = "#f38ba8",
    maroon = "#eba0ac",
    peach = "#fab387",
    yellow = "#f9e2af",
    green = "#a6e3a1",
    teal = "#94e2d5",
    sky = "#20dbfc",
    sapphire = "#74c7ec",
    blue = "#5ffcfc",
    lavender = "#b4befe",
    text = "#d9d9d9",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#9399b2",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#585b70",
    surface1 = "#191919",
    surface0 = "#121311",
    base = "#000000",
    mantle = "#090909",
    crust = "#111111",
}

local elegantvagrant_highlights = function(colors)
    return {
        LineNr = { fg = "#393939" },
        CursorLineNr = { fg = colors.subtext1, bold = true },
        Comment = { fg = colors.maroon }, -- Golden Comments

        -- Mini Statusbar
        MiniStatuslineModeNormal = { fg = colors.base, bg = "#7C5CFF" },
        MiniStatuslineModeInsert = { fg = colors.base, bg = "#f067fc" },
        MiniStatuslineModeVisual = { fg = colors.base, bg = "#02f789" },
        MiniStatuslineModeReplace = { fg = colors.base, bg = "#f4f113" },
        MiniStatuslineModeCommand = { fg = colors.base, bg = "#46d9ff" },
        MiniStatuslineModeOther = { fg = colors.base, bg = "#f38ba8" },
    }
end

local config = function()
    require("catppuccin").setup {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
            light = "latte",
            dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
            enabled = false, -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        float = {
            transparent = false, -- enable transparent floating windows
            solid = false, -- use solid styling for floating windows, see |winborder|
        },
        no_italic = true, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        lsp_styles = {
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
        default_integrations = false,
        auto_integrations = true,
        integrations = {
            alpha = false,
            barbecue = false,
            blink_cmp = { enabled = true, style = "bordered" },
            blink_indent = true,
            cmp = false,
            colorful_winsep = false,
            dap = false,
            dap_ui = false,
            dashboard = false,
            diffview = false,
            dropbar = false,
            flash = true,
            fzf = false,
            gitsigns = true,
            grug_far = false,
            illuminate = false,
            indent_blankline = {
                enabled = false,
                scope_color = "lavender",
            },
            leap = false,
            lir = false,
            lsp_trouble = true,
            markdown = true,
            mason = false,
            mini = { enabled = true, indentscope_color = "overlay2" },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                    ok = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                    ok = { "underline" },
                },
                inlay_hints = { background = true },
            },
            navic = false,
            neogit = true,
            neotree = false,
            noice = false,
            nvimtree = false,
            rainbow_delimiters = false,
            render_markdown = false,
            semantic_tokens = false,
            snacks = false,
            telescope = true,
            treesitter = true,
            treesitter_context = true,
            ufo = false,
            which_key = true,
        },
        custom_highlights = elegantvagrant_highlights,
        color_overrides = {
            mocha = elegantvagrant,
        },
    }
    vim.cmd.colorscheme "catppuccin-mocha"
end

return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = config,
}
