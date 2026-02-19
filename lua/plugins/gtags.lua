return {
  "rargo/nvim-global",
  lazy = false,
  config = function()
    require("nvim-global").setup({ Trouble = true })
  end,
}
