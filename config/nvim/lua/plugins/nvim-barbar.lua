return {
	"romgrk/barbar.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("barbar").setup({
			animation = false,
			auto_hide = 0,
			sidebar_filetypes = {
				NvimTree = true,
				["snacks_layout_box"] = { event = "BufWipeout" },
			},
			icons = {
				-- "│" va centrado en la celda, igual que el WinSeparator del
				-- explorador; el "▎" por defecto va pegado a la izquierda y
				-- quedaba corrido respecto a la linea de abajo.
				separator = { left = "│", right = "" },
				inactive = { separator = { left = "│", right = "" } },
				filetype = {
					custom_icons = false,
				},
				pinned = { button = "", filename = true },
			},
		})
	end,
}
