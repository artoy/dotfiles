local C = {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      c = { "clang_format" },
      cpp = { "clang_format" },
      objc = { "clang_format" },
      objcpp = { "clang_format" },
      go = { "goimports", "gofmt" },
    },
    formatters = {
      clang_format = {
        prepend_args = { "--style=file" },
      },
    },
    format_on_save = {
      timeout_ms = 1500,
      lsp_fallback = true,
    },
  },
}

return C
