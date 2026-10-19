-- Paleta pareja con colors/mono.lua: la barra no compite con el buffer.
local c = {
	bg      = "#000000",
	bg_dim  = "#0b0c0e",
	bg_hi   = "#23262a",
	gray_d  = "#4a5057",
	gray_l  = "#adb5bd",
	fg      = "#e9ecef",
	fg_hi   = "#ffffff",
	accent  = "#c9a227",
	replace = "#c05b52",
	command = "#8d959d",
	normal  = "#adb5bd", -- mono: NORMAL sigue en gris
}

-- Con el esquema andrea (rice andrea), la misma barra con su paleta.
local andrea = {
	bg      = "#09090F",
	bg_dim  = "#111116",
	bg_hi   = "#32302f",
	gray_d  = "#7c6f64",
	gray_l  = "#c5b18d",
	fg      = "#d4be98",
	fg_hi   = "#ddc7a1",
	accent  = "#d8a657",
	replace = "#ea6962",
	command = "#89b482",
	normal  = "#7daea3", -- celeste, igual que las carpetas del explorador
}

-- INSERT se lleva el acento, que es donde importa no equivocarse. El bloque
-- de NORMAL (y el de la posicion, a la derecha) usa c.normal.
local function mode(c, fg, bg)
	return {
		a = { fg = fg, bg = bg, gui = "bold" },
		b = { fg = c.gray_l, bg = c.bg_hi },
		c = { fg = c.gray_d, bg = c.bg_dim },
	}
end

local function build_theme(c)
	return {
		normal   = mode(c, c.bg, c.normal),
		insert   = mode(c, c.bg, c.accent),
		visual   = mode(c, c.bg, c.fg_hi),
		replace  = mode(c, c.bg, c.replace),
		command  = mode(c, c.bg, c.command),
		inactive = {
			a = { fg = c.gray_d, bg = c.bg_dim },
			b = { fg = c.gray_d, bg = c.bg_dim },
			c = { fg = c.gray_d, bg = c.bg_dim },
		},
	}
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			options = {
				-- Se decide aca y no arriba: este archivo se lee antes de
				-- que init.lua elija el colorscheme.
				theme = build_theme(vim.g.colors_name == "andrea" and andrea or c),
				-- Una sola barra abajo para todo el editor. Con una por ventana,
				-- el explorador mostraba la barra nativa con "[No Name]".
				globalstatus = true,
				-- Con el foco en el explorador o un picker, la barra sigue
				-- mostrando el archivo que se esta editando.
				ignore_focus = { "snacks_picker_list", "snacks_picker_input", "snacks_layout_box" },
			},
			sections = {
				lualine_c = { { "filename", file_status = true, path = 1 } },
			},
		})
	end,
}
