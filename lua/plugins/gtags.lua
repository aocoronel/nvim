return {
    "rargo/nvim-global",
    lazy = true,
    cmd = { "Global" },
    config = function() require("nvim-global").setup { Trouble = true } end,
}
