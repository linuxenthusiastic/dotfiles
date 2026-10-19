return {
  "sphamba/smear-cursor.nvim",
  opts = {
    -- preset suave: la estela persigue al cursor con inercia
    stiffness = 0.8,
    trailing_stiffness = 0.5,
    damping = 0.8,
    distance_stop_animating = 0.5,

    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    smear_insert_mode = true,
  },
  config = function(_, opts)
    require("smear_cursor").setup(opts)

    -- Dentro de kitty la estela del terminal tambien se dibuja, y se
    -- superpone con la del plugin. La apagamos mientras nvim esta abierto.
    if vim.env.KITTY_LISTEN_ON then
      local function kitty(...)
        vim.system({ "kitty", "@", "load-config", "--no-response", ... }, { text = true })
      end

      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("KittyTrailOff", { clear = true }),
        callback = function() kitty("-o", "cursor_trail=0") end,
      })

      -- --ignore-overrides descarta el override y relee kitty.conf,
      -- asi se restaura el valor real sin hardcodearlo aqui.
      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("KittyTrailOn", { clear = true }),
        callback = function() kitty("--ignore-overrides") end,
      })
    end
  end,
}
