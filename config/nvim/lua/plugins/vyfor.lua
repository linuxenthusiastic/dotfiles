return {
  "vyfor/cord.nvim",
  build = "cargo build --release",
  event = "VeryLazy",
  opts = {
    display = {
      show_time = true,
    },
  },
}