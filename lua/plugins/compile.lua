local config = function()
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
end

return {
  "ej-shafran/compile-mode.nvim",
  version = "^5.0.0",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = config,
}
