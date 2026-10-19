-- andrea -- la paleta del rice andrea (Gruvbox Material sobre #09090F).
--
-- Mismos grupos que colors/mono.lua; cambia solo la paleta. Los colores
-- base son los de kitty (~/.config/kitty/themes/andrea.conf), y la
-- sintaxis sigue el reparto de gruvbox-material:
--
--      rojo      keywords, control de flujo
--      verde     funciones, definicion y llamada
--      aqua      tipos, clases, structs
--      magenta   numeros, booleanos, constantes
--      amarillo  strings  <- tambien el acento de la interfaz
--      naranja   escapes, `this`/`self`, lo que rompe el flujo
--      azul      imports, modulos, namespaces
--
-- init.lua lo elige cuando ~/.config/bspwm/.rice dice "andrea".

local p = {
	bg      = "#09090F",
	bg_dim  = "#111116", -- flotantes, statusline
	bg_sel  = "#1a191c", -- cursorline
	bg_hi   = "#32302f", -- seleccion, item activo del menu
	border  = "#d4be98", -- contornos: el blanco de la terminal (color7)

	gray_dd = "#45403d", -- indent guides, whitespace
	gray_d  = "#7c6f64", -- comentarios, numeros de linea
	gray_m  = "#928374", -- operadores, puntuacion
	gray    = "#a89984", -- propiedades, campos
	gray_l  = "#c5b18d", -- parametros
	gray_ll = "#d4be98", -- variables

	fg      = "#d4be98", -- texto normal
	fg_hi   = "#ddc7a1", -- titulos, texto enfatizado

	accent    = "#d8a657",
	accent_d  = "#a7814a",
	accent_l  = "#e9b96e",

	kw      = "#ea6962",
	fn      = "#a9b665",
	ty      = "#89b482",
	const   = "#d3869b",
	mod     = "#7daea3",
	special = "#e78a4e",

	error   = "#ea6962",
	warn    = "#d8a657",
	info    = "#7daea3",
	hint    = "#89b482",
	ok      = "#a9b665",

	add     = "#a9b665",
	change  = "#d8a657",
	delete  = "#ea6962",
}

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "andrea"

-- Colores del :terminal, iguales a los de kitty (themes/andrea.conf).
local term = {
	"#32302f", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98",
	"#32302f", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98",
}
for i, c in ipairs(term) do
	vim.g["terminal_color_" .. (i - 1)] = c
end

local hl = function(group, spec)
	vim.api.nvim_set_hl(0, group, spec)
end

local groups = {
	--  ── base: interfaz, sin matiz ────────────────────────────────────
	Normal        = { fg = p.fg, bg = p.bg },
	NormalNC      = { fg = p.fg, bg = p.bg },
	NormalFloat   = { fg = p.fg, bg = p.bg_dim },
	FloatBorder   = { fg = p.border, bg = p.bg_dim },
	FloatTitle    = { fg = p.fg_hi, bg = p.bg_dim, bold = true },
	Cursor        = { fg = p.bg, bg = p.fg },
	CursorLine    = { bg = p.bg_sel },
	CursorColumn  = { bg = p.bg_sel },
	ColorColumn   = { bg = p.bg_dim },
	CursorLineNr  = { fg = p.fg_hi },
	LineNr        = { fg = p.gray_dd },
	SignColumn    = { bg = p.bg },
	FoldColumn    = { fg = p.gray_dd, bg = p.bg },
	Folded        = { fg = p.gray_d, bg = p.bg_dim, italic = true },
	VertSplit     = { fg = p.border },
	WinSeparator  = { fg = p.border },
	Visual        = { bg = p.bg_hi },
	VisualNOS     = { bg = p.bg_hi },
	NonText       = { fg = p.gray_dd },
	Whitespace    = { fg = p.gray_dd },
	SpecialKey    = { fg = p.gray_dd },
	EndOfBuffer   = { fg = p.bg },
	MatchParen    = { fg = p.accent, bold = true },
	Directory     = { fg = p.mod }, -- celeste: tambien el icono de carpeta del explorador
	Title         = { fg = p.fg_hi, bold = true },
	Conceal       = { fg = p.gray_d },
	QuickFixLine  = { bg = p.bg_hi },

	Search        = { fg = p.bg, bg = p.gray_l },
	IncSearch     = { fg = p.bg, bg = p.accent },
	CurSearch     = { fg = p.bg, bg = p.accent },
	Substitute    = { fg = p.bg, bg = p.accent_l },

	StatusLine    = { fg = p.fg, bg = p.bg_dim },
	StatusLineNC  = { fg = p.gray_d, bg = p.bg_dim },
	TabLine       = { fg = p.gray_d, bg = p.bg_dim },
	TabLineSel    = { fg = p.fg_hi, bg = p.bg },
	TabLineFill   = { bg = p.bg_dim },
	WinBar        = { fg = p.gray, bg = p.bg },
	WinBarNC      = { fg = p.gray_d, bg = p.bg },

	Pmenu         = { fg = p.fg, bg = p.bg_dim },
	PmenuSel      = { fg = p.fg_hi, bg = p.bg_hi },
	PmenuSbar     = { bg = p.bg_dim },
	PmenuThumb    = { bg = p.gray_dd },
	PmenuKind     = { fg = p.gray, bg = p.bg_dim },
	PmenuExtra    = { fg = p.gray_d, bg = p.bg_dim },
	WildMenu      = { fg = p.fg_hi, bg = p.bg_hi },

	ErrorMsg      = { fg = p.error },
	WarningMsg    = { fg = p.warn },
	MoreMsg       = { fg = p.gray_l },
	ModeMsg       = { fg = p.gray_l },
	Question      = { fg = p.gray_l },
	MsgArea       = { fg = p.fg },
	MsgSeparator  = { fg = p.border },

	--  ── sintaxis: aca si entra el matiz ──────────────────────────────
	-- Gris: lo que aparece en cada linea y no aporta leerlo dos veces.
	Comment       = { fg = p.gray_d, italic = true },
	Identifier    = { fg = p.gray_ll },
	Operator      = { fg = p.gray_m },
	Delimiter     = { fg = p.gray_m },

	-- Color: lo que si conviene reconocer de un vistazo.
	String        = { fg = p.accent },
	Character     = { fg = p.accent },

	Keyword       = { fg = p.kw, italic = true },
	Statement     = { fg = p.kw, italic = true },
	Conditional   = { fg = p.kw, italic = true },
	Repeat        = { fg = p.kw, italic = true },
	Label         = { fg = p.kw, italic = true },
	Exception     = { fg = p.kw, italic = true },

	Function      = { fg = p.fn },

	Type          = { fg = p.ty },
	StorageClass  = { fg = p.ty },
	Structure     = { fg = p.ty },
	Typedef       = { fg = p.ty },

	Constant      = { fg = p.const },
	Number        = { fg = p.const },
	Float         = { fg = p.const },
	Boolean       = { fg = p.const },

	PreProc       = { fg = p.mod },
	Include       = { fg = p.mod, italic = true },
	Define        = { fg = p.mod },
	Macro         = { fg = p.mod },
	PreCondit     = { fg = p.mod },

	Special       = { fg = p.special },
	SpecialChar   = { fg = p.special },
	SpecialComment= { fg = p.gray, italic = true },
	Tag           = { fg = p.kw },
	Debug         = { fg = p.error },
	Underlined    = { fg = p.fg, underline = true },
	Ignore        = { fg = p.gray_dd },
	Error         = { fg = p.error },
	Todo          = { fg = p.bg, bg = p.accent, bold = true },

	--  ── treesitter ───────────────────────────────────────────────────
	["@comment"]              = { link = "Comment" },
	["@comment.error"]        = { fg = p.bg, bg = p.error, bold = true },
	["@comment.warning"]      = { fg = p.bg, bg = p.warn, bold = true },
	["@comment.todo"]         = { link = "Todo" },
	["@comment.note"]         = { fg = p.bg, bg = p.info, bold = true },

	["@string"]               = { fg = p.accent },
	["@string.escape"]        = { fg = p.special },
	["@string.special"]       = { fg = p.special },
	["@string.special.url"]   = { fg = p.accent, underline = true },
	["@string.regexp"]        = { fg = p.const },
	["@character"]            = { fg = p.accent },
	["@character.special"]    = { fg = p.special },

	["@keyword"]              = { fg = p.kw, italic = true },
	["@keyword.function"]     = { fg = p.kw, italic = true },
	["@keyword.return"]       = { fg = p.kw, italic = true },
	["@keyword.operator"]     = { fg = p.kw, italic = true },
	["@keyword.conditional"]  = { fg = p.kw, italic = true },
	["@keyword.repeat"]       = { fg = p.kw, italic = true },
	["@keyword.exception"]    = { fg = p.kw, italic = true },
	["@keyword.coroutine"]    = { fg = p.kw, italic = true },
	["@keyword.import"]       = { fg = p.mod, italic = true },
	["@keyword.directive"]    = { fg = p.mod },

	["@function"]             = { fg = p.fn },
	["@function.call"]        = { fg = p.fn },
	["@function.method"]      = { fg = p.fn },
	["@function.method.call"] = { fg = p.fn },
	["@function.builtin"]     = { fg = p.fn, italic = true },
	["@function.macro"]       = { fg = p.mod },
	["@constructor"]          = { fg = p.ty },

	-- Lo mas frecuente del buffer se queda en gris a proposito.
	["@variable"]             = { fg = p.gray_ll },
	["@variable.builtin"]     = { fg = p.special, italic = true },
	["@variable.parameter"]   = { fg = p.gray_l, italic = true },
	["@variable.member"]      = { fg = p.gray },

	["@property"]             = { fg = p.gray },
	["@field"]                = { fg = p.gray },
	["@attribute"]            = { fg = p.mod },

	["@type"]                 = { fg = p.ty },
	["@type.builtin"]         = { fg = p.ty, italic = true },
	["@type.definition"]      = { fg = p.ty },
	["@module"]               = { fg = p.mod, italic = true },
	["@namespace"]            = { fg = p.mod, italic = true },

	["@constant"]             = { fg = p.const },
	["@constant.builtin"]     = { fg = p.const, italic = true },
	["@constant.macro"]       = { fg = p.const },
	["@number"]               = { fg = p.const },
	["@number.float"]         = { fg = p.const },
	["@boolean"]              = { fg = p.const },

	["@operator"]             = { fg = p.gray_m },
	["@punctuation.delimiter"]= { fg = p.gray_m },
	["@punctuation.bracket"]  = { fg = p.gray_m },
	["@punctuation.special"]  = { fg = p.special },

	["@label"]                = { fg = p.kw },

	["@tag"]                  = { fg = p.kw },
	["@tag.builtin"]          = { fg = p.kw },
	["@tag.attribute"]        = { fg = p.ty, italic = true },
	["@tag.delimiter"]        = { fg = p.gray_m },

	["@markup.heading"]       = { fg = p.fg_hi, bold = true },
	["@markup.strong"]        = { fg = p.fg_hi, bold = true },
	["@markup.italic"]        = { fg = p.fg, italic = true },
	["@markup.strikethrough"] = { fg = p.gray_d, strikethrough = true },
	["@markup.link"]          = { fg = p.accent, underline = true },
	["@markup.link.label"]    = { fg = p.ty },
	["@markup.link.url"]      = { fg = p.gray_d, underline = true },
	["@markup.raw"]           = { fg = p.accent },
	["@markup.raw.block"]     = { fg = p.accent },
	["@markup.list"]          = { fg = p.kw },
	["@markup.list.checked"]  = { fg = p.ok },
	["@markup.list.unchecked"]= { fg = p.gray_m },
	["@markup.quote"]         = { fg = p.gray_d, italic = true },

	["@diff.plus"]            = { fg = p.add },
	["@diff.minus"]           = { fg = p.delete },
	["@diff.delta"]           = { fg = p.change },

	--  ── LSP: mismos matices que treesitter ───────────────────────────
	-- Sin esto, los tokens semanticos del servidor pisan al parser y las
	-- categorias dejan de coincidir entre si.
	["@lsp.type.parameter"]     = { fg = p.gray_l, italic = true },
	["@lsp.type.property"]      = { fg = p.gray },
	["@lsp.type.variable"]      = { fg = p.gray_ll },
	["@lsp.type.namespace"]     = { fg = p.mod, italic = true },
	["@lsp.type.class"]         = { fg = p.ty },
	["@lsp.type.interface"]     = { fg = p.ty },
	["@lsp.type.enum"]          = { fg = p.ty },
	["@lsp.type.type"]          = { fg = p.ty },
	["@lsp.type.typeParameter"] = { fg = p.ty, italic = true },
	["@lsp.type.enumMember"]    = { fg = p.const },
	["@lsp.type.function"]      = { fg = p.fn },
	["@lsp.type.method"]        = { fg = p.fn },
	["@lsp.type.keyword"]       = { fg = p.kw, italic = true },
	["@lsp.type.decorator"]     = { fg = p.mod },
	["@lsp.mod.deprecated"]     = { strikethrough = true },

	LspReferenceText            = { bg = p.bg_hi },
	LspReferenceRead            = { bg = p.bg_hi },
	LspReferenceWrite           = { bg = p.bg_hi, underline = true },
	LspInlayHint                = { fg = p.gray_dd, bg = p.bg_dim, italic = true },
	LspCodeLens                 = { fg = p.gray_d, italic = true },
	LspSignatureActiveParameter = { fg = p.accent, bold = true },

	--  ── diagnosticos: aca el color SI es informacion ─────────────────
	DiagnosticError            = { fg = p.error },
	DiagnosticWarn             = { fg = p.warn },
	DiagnosticInfo             = { fg = p.info },
	DiagnosticHint             = { fg = p.hint },
	DiagnosticOk               = { fg = p.ok },

	DiagnosticVirtualTextError = { fg = p.error, bg = "#1a0e0d" },
	DiagnosticVirtualTextWarn  = { fg = p.warn, bg = "#191408" },
	DiagnosticVirtualTextInfo  = { fg = p.info, bg = "#0d1417" },
	DiagnosticVirtualTextHint  = { fg = p.hint, bg = "#0d1310" },

	DiagnosticUnderlineError   = { sp = p.error, undercurl = true },
	DiagnosticUnderlineWarn    = { sp = p.warn, undercurl = true },
	DiagnosticUnderlineInfo    = { sp = p.info, undercurl = true },
	DiagnosticUnderlineHint    = { sp = p.hint, undercurl = true },

	DiagnosticUnnecessary      = { fg = p.gray_dd },
	DiagnosticDeprecated       = { fg = p.gray_d, strikethrough = true },

	--  ── diff / git ───────────────────────────────────────────────────
	DiffAdd      = { fg = p.add, bg = "#0d130b" },
	DiffChange   = { fg = p.change, bg = "#13110b" },
	DiffDelete   = { fg = p.delete, bg = "#150c0b" },
	DiffText     = { fg = p.fg_hi, bg = "#26210f" },
	Added        = { fg = p.add },
	Changed      = { fg = p.change },
	Removed      = { fg = p.delete },

	GitSignsAdd    = { fg = p.add },
	GitSignsChange = { fg = p.change },
	GitSignsDelete = { fg = p.delete },

	--  ── plugins: interfaz, todo en gris ──────────────────────────────
	-- barbar
	BufferCurrent        = { fg = p.fg_hi, bg = p.bg },
	BufferCurrentIndex   = { fg = p.fg_hi, bg = p.bg },
	BufferCurrentMod     = { fg = p.accent, bg = p.bg },
	BufferCurrentSign    = { fg = p.border, bg = p.bg },
	BufferCurrentTarget  = { fg = p.accent_l, bg = p.bg, bold = true },
	BufferVisible        = { fg = p.gray_l, bg = p.bg_dim },
	BufferVisibleIndex   = { fg = p.gray_l, bg = p.bg_dim },
	BufferVisibleMod     = { fg = p.accent_d, bg = p.bg_dim },
	BufferVisibleSign    = { fg = p.border, bg = p.bg_dim },
	BufferVisibleTarget  = { fg = p.accent_l, bg = p.bg_dim, bold = true },
	BufferInactive       = { fg = p.gray_d, bg = p.bg_dim },
	BufferInactiveIndex  = { fg = p.gray_d, bg = p.bg_dim },
	BufferInactiveMod    = { fg = p.accent_d, bg = p.bg_dim },
	BufferInactiveSign   = { fg = p.border, bg = p.bg_dim },
	BufferInactiveTarget = { fg = p.accent_l, bg = p.bg_dim, bold = true },
	BufferTabpageFill    = { fg = p.bg_dim, bg = p.bg_dim },
	BufferOffset         = { fg = p.gray_d, bg = p.bg_dim },

	-- blink.cmp
	BlinkCmpMenu              = { fg = p.fg, bg = p.bg_dim },
	BlinkCmpMenuBorder        = { fg = p.border, bg = p.bg_dim },
	BlinkCmpMenuSelection     = { fg = p.fg_hi, bg = p.bg_hi },
	BlinkCmpLabel             = { fg = p.fg },
	BlinkCmpLabelMatch        = { fg = p.accent, bold = true },
	BlinkCmpLabelDeprecated   = { fg = p.gray_d, strikethrough = true },
	BlinkCmpLabelDescription  = { fg = p.gray_d },
	BlinkCmpKind              = { fg = p.gray },
	BlinkCmpSource            = { fg = p.gray_d },
	BlinkCmpDoc               = { fg = p.fg, bg = p.bg_dim },
	BlinkCmpDocBorder         = { fg = p.border, bg = p.bg_dim },
	BlinkCmpSignatureHelp     = { fg = p.fg, bg = p.bg_dim },
	BlinkCmpSignatureHelpActiveParameter = { fg = p.accent, bold = true },

	-- snacks
	SnacksIndent          = { fg = p.gray_dd },
	SnacksIndentScope     = { fg = p.gray_d },
	-- El explorador (<leader>e) y los pickers van con el fondo del editor:
	-- con bg_dim el panel lateral se veia como un bloque mas claro.
	SnacksNormal          = { fg = p.fg, bg = p.bg },
	SnacksWinBar          = { fg = p.fg_hi, bg = p.bg },
	SnacksPicker          = { fg = p.fg, bg = p.bg },
	SnacksPickerBorder    = { fg = p.border, bg = p.bg },
	SnacksPickerInputBorder   = { fg = p.border, bg = p.bg },
	SnacksPickerBoxBorder     = { fg = p.border, bg = p.bg },
	SnacksPickerListBorder    = { fg = p.border, bg = p.bg },
	SnacksPickerPreviewBorder = { fg = p.border, bg = p.bg },
	SnacksPickerTitle     = { fg = p.fg_hi, bg = p.bg, bold = true },
	SnacksBackdrop        = { bg = p.bg },
	SnacksPickerDir       = { fg = p.gray_d, italic = true },
	-- Explorador (<leader>e): nombres en cursiva.
	SnacksPickerFile          = { fg = p.fg, italic = true },
	SnacksPickerDirectory     = { fg = p.gray_ll, italic = true },
	SnacksPickerLink          = { fg = p.mod, italic = true },
	SnacksPickerPathHidden    = { fg = p.gray_d, italic = true },
	SnacksPickerPathIgnored   = { fg = p.gray_dd, italic = true },
	SnacksPickerMatch     = { fg = p.accent, bold = true },
	SnacksPickerSelected  = { fg = p.accent },
	SnacksPickerTotals    = { fg = p.gray_d },
	SnacksDashboardHeader = { fg = p.fg_hi },
	SnacksDashboardIcon   = { fg = p.accent },
	SnacksDashboardDesc   = { fg = p.gray_l },
	SnacksDashboardKey    = { fg = p.accent },
	SnacksDashboardFooter = { fg = p.gray_d },

	-- which-key
	WhichKey          = { fg = p.accent },
	WhichKeyGroup     = { fg = p.gray_ll },
	WhichKeyDesc      = { fg = p.fg },
	WhichKeySeparator = { fg = p.gray_dd },
	WhichKeyFloat     = { bg = p.bg_dim },
	WhichKeyBorder    = { fg = p.border, bg = p.bg_dim },

	-- todo-comments / mini.hipatterns dejan sus propios grupos.
	MiniHipatternsFixme = { fg = p.bg, bg = p.error, bold = true },
	MiniHipatternsHack  = { fg = p.bg, bg = p.warn, bold = true },
	MiniHipatternsTodo  = { fg = p.bg, bg = p.info, bold = true },
	MiniHipatternsNote  = { fg = p.bg, bg = p.ok, bold = true },
}

for group, spec in pairs(groups) do
	hl(group, spec)
end
