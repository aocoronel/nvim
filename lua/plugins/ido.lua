return {
    "gelguy/wilder.nvim",
    lazy = false,
    config = function()
        local wilder = require "wilder"
        wilder.setup { modes = { ":", "/", "?" } }
    end,
}
