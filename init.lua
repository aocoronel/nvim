if vim.g.neovide then
    vim.g.neovide_scale_factor = 0.9
    vim.g.neovide_scroll_animation_length = 0.0
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h13"
end

local pack_ok, pack_err = pcall(vim.pack.add, {
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/catppuccin/nvim",
    "https://github.com/gelguy/wilder.nvim",
    "https://github.com/junegunn/vim-easy-align",
    "https://github.com/junkblocker/git-time-lapse",
    "https://github.com/neovim/nvim-lspconfig", -- depends on blink
    "https://github.com/norcalli/nvim-colorizer.lua",
    "https://github.com/nvim-telescope/telescope.nvim", -- depends on plenary
    "https://github.com/rargo/nvim-global", -- depends on telescope
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/terryma/vim-expand-region",
    "https://github.com/NeogitOrg/neogit", -- depends on plenary, diffview and telescope
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/NStefan002/visual-surround.nvim",
    "https://github.com/chrisgrieser/nvim-scissors", -- depends on telescope
    "https://github.com/folke/which-key.nvim",
    "https://github.com/nanotee/zoxide.vim",
    { src = "https://github.com/jake-stewart/multicursor.nvim", version = "1.0" },
    { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
    "https://github.com/ej-shafran/compile-mode.nvim", -- depends on baleia, plenary
    { src = "https://github.com/m00qek/baleia.nvim", version = "v1.3.0" },
})
if not pack_ok then
    vim.notify(
        "vim.pack: some plugins failed to install. Run :lua vim.pack.update() to retry.\n" .. pack_err,
        vim.log.levels.WARN
    )
end

require "config.init"

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

-- Zd <path>
vim.api.nvim_create_user_command("Zd", function(opts)
    vim.cmd("Z " .. opts.args)
    vim.cmd "edit ."
end, {
    nargs = "*",
    complete = "file",
})

require("which-key").setup {
    delay = 0,
    icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
            Up = "<Up> ",
            Down = "<Down> ",
            Left = "<Left> ",
            Right = "<Right> ",
            C = "<C-…> ",
            M = "<M-…> ",
            D = "<D-…> ",
            S = "<S-…> ",
            CR = "<CR> ",
            Esc = "<Esc> ",
            ScrollWheelDown = "<ScrollWheelDown> ",
            ScrollWheelUp = "<ScrollWheelUp> ",
            NL = "<NL> ",
            BS = "<BS> ",
            Space = "<Space> ",
            Tab = "<Tab> ",
            F1 = "<F1>",
            F2 = "<F2>",
            F3 = "<F3>",
            F4 = "<F4>",
            F5 = "<F5>",
            F6 = "<F6>",
            F7 = "<F7>",
            F8 = "<F8>",
            F9 = "<F9>",
            F10 = "<F10>",
            F11 = "<F11>",
            F12 = "<F12>",
        },
    },
    preset = "emacs",
    defaults = {},
    spec = {
        {
            mode = { "n", "v" },
            { "<leader><tab>", group = "tabs" },
            { "<leader>c", group = "code" },
            { "<leader>d", group = "debug" },
            { "<leader>dp", group = "profiler" },
            { "<leader>f", group = "file/find" },
            { "<leader>gh", group = "hunks" },
            { "<leader>q", group = "quit/session" },
            { "<leader>s", group = "search" },
            { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
            { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
            { "[", group = "prev" },
            { "]", group = "next" },
            { "g", group = "goto" },
            { "gs", group = "surround" },
            { "z", group = "fold" },
            {
                "<leader>b",
                group = "buffer",
                expand = function() return require("which-key.extras").expand.buf() end,
            },
            {
                "<leader>w",
                group = "windows",
                proxy = "<c-w>",
                expand = function() return require("which-key.extras").expand.win() end,
            },
            -- better descriptions
            { "gx", desc = "Open with system app" },
        },
    },
}

require("scissors").setup {
    snippetDir = "~/.config/nvim/snippets/",
    editSnippetPopup = {
        height = 0.4,
        width = 0.6,
        border = "rounded",
        keymaps = {
            cancel = "q",
            saveChanges = "<CR>",
            goBackToSearch = "<BS>",
            deleteSnippet = "<C-BS>",
            duplicateSnippet = "<C-d>",
            openInFile = "<C-o>",
            insertNextPlaceholder = "<C-p>",
            showHelp = "?",
        },
    },
    backdrop = {
        enabled = true,
        blend = 50,
    },
    icons = {
        scissors = "󰩫",
    },
}

require("oil").setup {
    default_file_explorer = true,
    columns = {
        -- "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
    },
    buf_options = {
        buflisted = false,
        bufhidden = "hide",
    },
    win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
    },
    delete_to_trash = false,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
        enabled = false,
    },
    constrain_cursor = "editable",
    watch_for_changes = false,
    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    use_default_keymaps = true,
    view_options = {
        show_hidden = false,
        is_hidden_file = function(name, bufnr)
            local m = name:match "^%."
            return m ~= nil
        end,
        is_always_hidden = function(name, bufnr) return false end,
        natural_order = "fast",
        case_insensitive = false,
        sort = {
            { "type", "asc" },
            { "name", "asc" },
        },
        highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan) return nil end,
    },
    float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = nil,
        win_options = {
            winblend = 0,
        },
        get_win_title = nil,
        preview_split = "auto",
        override = function(conf) return conf end,
    },
    preview_win = {
        update_on_cursor_moved = true,
        preview_method = "fast_scratch",
        disable_preview = function(filename) return false end,
        win_options = {},
    },
    confirmation = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = nil,
        win_options = {
            winblend = 0,
        },
    },
    progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = nil,
        minimized_border = "none",
        win_options = {
            winblend = 0,
        },
    },
    ssh = {
        border = nil,
    },
    keymaps_help = {
        border = nil,
    },
}

require("wilder").setup {
    modes = { ":", "/", "?" },
}

require("telescope").setup {
    defaults = {
        file_ignore_patterns = {
            "%.git",
        },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            preview_width = 0.5,
            horizontal = {
                size = {
                    width = "95%",
                    height = "95%",
                },
            },
        },
    },
    pickers = {
        find_files = {
            previewer = true,
            hidden = true,
            theme = "ivy",
        },
        live_grep = {
            previewer = true,
            theme = "ivy",
        },
        buffers = {
            previewer = true,
            theme = "ivy",
        },
    },
    keys = {},
}

vim.g.compile_mode = {
    default_command = {
        python = "python %",
        lua = "lua %",
        sh = "sh %",
        c = "cc -o %:r % && ./%:r",
    },
    baleia_setup = true,
    bang_expansion = true,
    error_regexp_table = {},
    error_ignore_file_list = {},
    error_threshold = require("compile-mode").level.WARNING,
    auto_jump_to_first_error = false,
    error_locus_highlight = 500,
    use_diagnostics = false,
    recompile_no_fail = true,
    ask_about_save = true,
    ask_to_interrupt = false,
    buffer_name = "*compilation*",
    time_format = "%a %b %e %H:%M:%S",
    hidden_output = {},
    environment = nil,
    clear_environment = false,
    input_word_completion = true,
    hidden_buffer = false,
    focus_compilation_buffer = false,
    auto_scroll = true,
    use_circular_error_navigation = true,
    debug = false,
    use_pseudo_terminal = false,
}

require("blink.cmp").setup {
    keymap = {
        preset = "none",
        ["<CR>"] = { "accept", "fallback" },
        ["<M-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<M-n>"] = { "select_next", "fallback_to_mappings" },
        ["<M-b>"] = { "scroll_documentation_up", "fallback" },
        ["<M-f>"] = { "scroll_documentation_down", "fallback" },
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
}

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

require("conform").setup {
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
        odin = { "odinfmt" },
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
        zig = { "zig fmt" },
    },
    formatters = {
        injected = { options = { ignore_errors = true } },
        odinfmt = {
            command = "odinfmt",
            args = { "-stdin" },
            stdin = true,
        },
    },
}

local lspconfig = vim.lsp
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
        map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
        map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
        map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

        local function client_supports_method(client, method, bufnr)
            if vim.fn.has "nvim-0.11" == 1 then
                return client:supports_method(method, bufnr)
            else
                return client.supports_method(method, { bufnr = bufnr })
            end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
        then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
                end,
            })
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map(
                "<leader>th",
                function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
                "[T]oggle Inlay [H]ints"
            )
        end
    end,
})

vim.diagnostic.config {
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    } or {},
    virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
}

-- lua
lspconfig.enable "lua_ls"
lspconfig.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            capabilities = capabilities,
            workspace = {
                library = {
                    vim.fn.expand "$VIMRUNTIME/lua",
                    vim.fn.expand "$XDG_CONFIG_HOME" .. "/nvim/lua",
                },
            },
        },
    },
})

-- Odin
-- lspconfig.enable("ols")
-- lspconfig.config("ols", {
--   cmd = { "ols" },
--   filetypes = { "odin" },
-- })

-- Nix
-- lspconfig.enable("nix_ls")
-- lspconfig.config("nix_ls", {
--   cmd = { "nil" },
--   filetypes = { "nix" },
--   root_markers = { "flake.nix", ".git" },
-- })

-- json
-- lspconfig.enable("jsonls")
-- lspconfig.config("jsonls", {
--   filetypes = { "json", "jsonc" },
--   init_options = {
--     provideFormatter = true,
--   },
-- })

-- python
-- lspconfig.enable("pyright")
-- lspconfig.config("pyright", {
--   settings = {
--     pyright = {
--       disableOrganizeImports = false,
--       analysis = {
--         useLibraryCodeForTypes = true,
--         autoSearchPaths = true,
--         diagnosticMode = "workspace",
--         autoImportCompletions = true,
--       },
--     },
--   },
-- })

-- golang
-- lspconfig.enable("gopls")
-- lspconfig.config("gopls", {
--   filetypes = {
--     "go",
--     "gomod",
--     "gowork",
--     "gotmpl",
--   },
-- })

-- typescript
-- lspconfig.enable("ts_ls")
-- lspconfig.config("ts_ls", {
--   filetypes = {
--     "typescript",
--     "javascript",
--     "typescriptreact",
--     "javascriptreact",
--   },
--   commands = {},
--   settings = {
--     typescript = {
--       indentStyle = "space",
--       indentSize = 2,
--     },
--   },
-- })

-- bash
lspconfig.enable "bashls"
lspconfig.config("bashls", {
    filetypes = { "sh", "aliasrc" },
    capabilities = capabilities,
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
        },
    },
})

-- markdown
lspconfig.enable "marksman"
lspconfig.config("marksman", {
    filetypes = { "markdown", "markdown.mdx" },
    capabilities = capabilities,
})
lspconfig.enable "markdown_oxide"
lspconfig.config("markdown_oxide", {
    filetypes = { "markdown" },
    capabilities = capabilities,
})

-- Zig
lspconfig.enable "zls"
lspconfig.config("zls", {
    filetypes = { "zig" },
    capabilities = capabilities,
})

-- rust
lspconfig.enable "rust_analyzer"
lspconfig.config("rust_analyzer", {
    filetypes = { "rust" },
    capabilities = capabilities,
})

-- C/C++
lspconfig.enable "clangd"
lspconfig.config("clangd", {
    capabilities = {
        capabilities,
        offsetEncoding = { "utf-8", "utf-16" },
    },
    textDocument = {
        completion = {
            editsNearCursor = true,
        },
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    keys = {
        { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
    },
    root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac", -- AutoTools
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja",
        ".git",
    },
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
})

local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { reverse = true })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorMatchPreview", { link = "Search" })
hl(0, "MultiCursorDisabledCursor", { reverse = true })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })

vim.cmd.colorscheme "catppuccin-mocha"
