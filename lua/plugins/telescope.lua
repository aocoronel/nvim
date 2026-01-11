local keymap = vim.keymap

local config = function()
    local telescope = require "telescope"
    local builtin = require "telescope.builtin"
    telescope.setup {
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
            },
            live_grep = {
                previewer = true,
            },
            buffers = {
                previewer = true,
            },
        },
        keys = {},
    }
end

return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    version = false,
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = config,
}
