require("vim-options")
require("keymaps")
require("cmds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" }, -- loads all plugins in plugins/
  },
  defaults = {
    lazy = false, -- plugins are not lazy loaded by default
  },
})

-- Va despues de lazy.setup: asi los grupos que definen los plugins al
-- cargar ya existen y mono los sobreescribe en vez de perderse.
-- El rice andrea tiene su propio esquema; el resto sigue con mono.
local rice_file = io.open(vim.fn.expand("~/.config/bspwm/.rice"))
local rice = rice_file and vim.trim(rice_file:read("*l") or "") or ""
if rice_file then rice_file:close() end
vim.cmd.colorscheme(rice == "andrea" and "andrea" or "mono")

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { current_line = true },
  underline = true,
  update_in_insert = false
})

-- Desactivado: para volver a usar el contorno y el margen, borrar la
-- linea "--[[" de abajo y la "--]]" del final.
--[[
-- Rice andrea: contorno blanco redondeado alrededor de la terminal mientras
-- nvim esta abierto. Lo dibuja kitty como imagen de fondo: un PNG del tamano
-- exacto de la ventana con la linea metida INSET px hacia adentro y radio
-- concentrico al corner-radius de picom, asi el redondeo no la corta (con
-- picom en xrender no hay otra forma de meter el borde hacia adentro).
-- La linea queda dentro del padding de kitty, nunca debajo del texto.
if rice == "andrea" and vim.env.WINDOWID and vim.env.KITTY_LISTEN_ON
  and vim.fn.executable("magick") == 1 and vim.fn.executable("xdotool") == 1 then
  local CORNER_RADIUS = 15 -- el de ~/.config/bspwm/config/picom.conf
  local INSET = 5          -- separacion entre la linea y el filo de la ventana
  local PADDING = 14       -- separacion entre el filo y el texto
  local frame = vim.fn.stdpath("cache") .. "/andrea-frame-" .. vim.env.WINDOWID .. ".png"

  local kitty = function(...)
    vim.fn.system({ "kitty", "@", ... })
  end

  local draw = function()
    local geo = vim.fn.system({ "xdotool", "getwindowgeometry", "--shell", vim.env.WINDOWID })
    local w = tonumber(geo:match("WIDTH=(%d+)"))
    local h = tonumber(geo:match("HEIGHT=(%d+)"))
    if not (w and h) then return end
    local r = CORNER_RADIUS - INSET
    vim.fn.system({
      "magick", "-size", w .. "x" .. h, "xc:#09090F",
      "-fill", "none", "-stroke", "#d4be98", "-strokewidth", "1",
      "-draw", string.format("roundrectangle %d,%d %d,%d %d,%d", INSET, INSET, w - INSET - 1, h - INSET - 1, r, r),
      frame,
    })
    kitty("set-background-image", "--layout", "clamped", frame)
  end

  local group = vim.api.nvim_create_augroup("andrea_border", { clear = true })
  vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
    group = group,
    callback = function()
      kitty("set-spacing", "padding=" .. PADDING)
      draw()
    end,
  })
  vim.api.nvim_create_autocmd("VimResized", { group = group, callback = draw })
  vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, {
    group = group,
    callback = function()
      kitty("set-background-image", "none")
      kitty("set-spacing", "padding=default")
      os.remove(frame)
    end,
  })
end
--]]
