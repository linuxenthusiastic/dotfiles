-- nvim-treesitter esta clavado en la rama `main` (ver lazy-lock.json), que
-- reescribio la API. Ahi `setup()` acepta un solo campo, `install_dir`:
-- las opciones `highlight`, `indent` y `auto_install` de la rama `master`
-- se descartan en silencio, sin error ni aviso.
--
-- Resultado: no habia ni un parser instalado y el resaltado nunca
-- arrancaba, asi que todo lo pintaba la sintaxis regex vieja de vim. Esa
-- sintaxis adivina por nombre, no por gramatica, y se equivoca feo: en un
-- .ts marcaba `.cache` como keyword y `.set` como metodo HTTP. En
-- monocromo no se notaba; con matiz salta a la vista.
--
-- En `main` el resaltado se arranca a mano, por buffer.

local ensure = {
	-- Sin `jsonc`: en la rama `main` no es un lenguaje propio y cada
	-- arranque tiraba "skipping unsupported language".
	"bash", "css", "diff", "dockerfile", "gitcommit", "gitignore",
	"go", "gomod", "html", "javascript", "json", "lua", "luadoc",
	"markdown", "markdown_inline", "python", "query", "regex", "scss",
	"sql", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup({})

			-- Instala lo que falte, una sola vez y en segundo plano.
			local have = {}
			for _, lang in ipairs(require("nvim-treesitter.config").get_installed("parsers")) do
				have[lang] = true
			end
			local missing = vim.tbl_filter(function(lang)
				return not have[lang]
			end, ensure)
			if #missing > 0 then
				ts.install(missing)
			end

			-- El resaltado va por FileType: `main` no lo enciende solo.
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("mono_treesitter", { clear = true }),
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
					if not lang then
						return
					end
					-- language.add() falla si el parser no esta: sin esto,
					-- cada buffer de un lenguaje no instalado tira error.
					if not pcall(vim.treesitter.language.add, lang) then
						return
					end
					pcall(vim.treesitter.start, ev.buf, lang)
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
