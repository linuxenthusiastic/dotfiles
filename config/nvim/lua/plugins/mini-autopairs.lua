return {
  "echasnovski/mini.pairs",
  version = "*",
  event = "InsertEnter",
  config = function()
    require("mini.pairs").setup({
      mappings = {
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
      },
    })

    -- Enter dentro de {} abre con indentación
    vim.keymap.set("i", "<CR>", function()
      local pair = MiniPairs.cr()
      return pair
    end, { expr = true, noremap = true })
  end,
}
