local config = function()
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

            ---@param client vim.lsp.Client
            ---@param method vim.lsp.protocol.Method
            ---@param bufnr? integer some lsp support methods only in specific files
            ---@return boolean
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

            if
                client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
            then
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
            fallbackFlags = { "-std=c99" },
        },
    })
end

return {
    "neovim/nvim-lspconfig",
    config = config,
    event = "BufReadPre",
    lazy = true,
    dependencies = {
        "saghen/blink.cmp",
    },
    opts = {
        servers = {
            marksman = {
                cmd = {
                    "sh",
                    "-c",
                    "test -x /run/current-system/sw/bin/marksman && { /run/current-system/sw/bin/marksman server; } || { marksman server; }",
                },
            },
            markdown_oxide = {
                cmd = {
                    "sh",
                    "-c",
                    "test -x /run/current-system/sw/bin/markdown-oxide && { /run/current-system/sw/bin/markdown-oxide server; } || { markdown-oxide server; }",
                },
            },
            lua_ls = {
                -- cmd = { ... },
                -- filetypes = { ... },
                -- capabilities = {},
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        diagnostics = { disable = { "missing-fields" } },
                    },
                },
            },
        },
    },
}
