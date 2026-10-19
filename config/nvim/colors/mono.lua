-- mono -- interfaz monocroma sobre negro puro; el color vive en el codigo.
--
-- Dos reglas separadas, a proposito:
--
-- 1. La INTERFAZ es blanco y negro. Statusline, tabline, menus, bordes,
--    pickers, dashboard: todo en la escala de grises que coincide con la
--    paleta de kitty (~/.config/kitty/themes/varinka.conf). Ahi la
--    jerarquia la hace la luminosidad, y el unico color es el acento.
--
-- 2. La SINTAXIS si lleva matiz, porque ahi el color es informacion: sirve
--    para saber que es cada cosa sin leerla. Aun asi el gris sigue siendo
--    el default -- lo que aparece en casi cada linea (variables,
--    propiedades, operadores, puntuacion, comentarios) se queda gris, y
--    el matiz entra solo en las categorias que uno necesita reconocer de
--    un vistazo. Son ocho tonos desaturados a la misma altura (L* ~70,
--    croma bajo), asi que leen como una familia y no como un arcoiris:
--
--      lavanda        keywords, control de flujo
--      azul           funciones, definicion y llamada
--      verde agua     tipos, clases, structs
--      ambar quemado  numeros, booleanos, constantes
--      ambar          strings  <- el acento historico del esquema
--      terracota      escapes, `this`/`self`, lo que rompe el flujo
--      malva          imports, modulos, namespaces
--      salvia         diffs en positivo
--
-- Para cambiar el acento, tocar `accent` (y sus dos variantes) nada mas.
-- Para volver a monocromo puro, apuntar los matices de la familia a gris.

local p = {
	bg      = "#000000",
	bg_dim  = "#0b0c0e", -- flotantes, statusline
	bg_sel  = "#16181b", -- cursorline
	bg_hi   = "#23262a", -- seleccion, item activo del menu
	border  = "#2e3236",

	gray_dd = "#3a3f45", -- indent guides, whitespace
	gray_d  = "#4a5057", -- comentarios, numeros de linea
	gray_m  = "#6c757d", -- operadores, puntuacion
	gray    = "#8d959d", -- propiedades, campos
	gray_l  = "#adb5bd", -- parametros
	gray_ll = "#ced4da", -- variables

	fg      = "#e9ecef", -- texto normal
	fg_hi   = "#ffffff", -- titulos, texto enfatizado

	-- El acento. Ambar apagado: calido sobre negro sin gritar.
	accent    = "#c9a227",
	accent_d  = "#8a6f1c",
	accent_l  = "#e0bc4a",

	-- La familia de matices. Solo para sintaxis: no entra en la interfaz.
	red     = "#cf8d80", -- terracota
	orange  = "#c99a6d", -- ambar quemado
	teal    = "#7fada6", -- verde agua
	blue    = "#8aa8c9", -- azul acero
	violet  = "#a998c9", -- lavanda
	mauve   = "#c395b2", -- malva

	error   = "#c05b52",
	warn    = "#c9a227",
	info    = "#7f9aa6",
	hint    = "#6f8a7d",
	ok      = "#7f9a6f",

	add     = "#5f7a52",
	change  = "#7a6f3f",
	delete  = "#8a4f47",
}

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "mono"

-- Colores del :terminal, iguales a los de kitty.
local term = {
	p.bg, p.fg_hi, "#adb5bd", "#dee2e6", "#6c757d", "#ced4da", "#8d959d", p.fg,
	"#4a5057", "#ffffff", "#c3cad1", "#eef1f4", "#868e96", "#e0e4e8", "#a6adb5", "#ffffff",
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
	Directory     = { fg = p.gray_ll },
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

	Keyword       = { fg = p.violet, italic = true },
	Statement     = { fg = p.violet, italic = true },
	Conditional   = { fg = p.violet, italic = true },
	Repeat        = { fg = p.violet, italic = true },
	Label         = { fg = p.violet, italic = true },
	Exception     = { fg = p.violet, italic = true },

	Function      = { fg = p.blue },

	Type          = { fg = p.teal },
	StorageClass  = { fg = p.teal },
	Structure     = { fg = p.teal },
	Typedef       = { fg = p.teal },

	Constant      = { fg = p.orange },
	Number        = { fg = p.orange },
	Float         = { fg = p.orange },
	Boolean       = { fg = p.orange },

	PreProc       = { fg = p.mauve },
	Include       = { fg = p.mauve, italic = true },
	Define        = { fg = p.mauve },
	Macro         = { fg = p.mauve },
	PreCondit     = { fg = p.mauve },

	Special       = { fg = p.red },
	SpecialChar   = { fg = p.red },
	SpecialComment= { fg = p.gray, italic = true },
	Tag           = { fg = p.violet },
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
	["@string.escape"]        = { fg = p.red },
	["@string.special"]       = { fg = p.red },
	["@string.special.url"]   = { fg = p.accent, underline = true },
	["@string.regexp"]        = { fg = p.orange },
	["@character"]            = { fg = p.accent },
	["@character.special"]    = { fg = p.red },

	["@keyword"]              = { fg = p.violet, italic = true },
	["@keyword.function"]     = { fg = p.violet, italic = true },
	["@keyword.return"]       = { fg = p.violet, italic = true },
	["@keyword.operator"]     = { fg = p.violet, italic = true },
	["@keyword.conditional"]  = { fg = p.violet, italic = true },
	["@keyword.repeat"]       = { fg = p.violet, italic = true },
	["@keyword.exception"]    = { fg = p.violet, italic = true },
	["@keyword.coroutine"]    = { fg = p.violet, italic = true },
	["@keyword.import"]       = { fg = p.mauve, italic = true },
	["@keyword.directive"]    = { fg = p.mauve },

	["@function"]             = { fg = p.blue },
	["@function.call"]        = { fg = p.blue },
	["@function.method"]      = { fg = p.blue },
	["@function.method.call"] = { fg = p.blue },
	["@function.builtin"]     = { fg = p.blue, italic = true },
	["@function.macro"]       = { fg = p.mauve },
	["@constructor"]          = { fg = p.teal },

	-- Lo mas frecuente del buffer se queda en gris a proposito.
	["@variable"]             = { fg = p.gray_ll },
	["@variable.builtin"]     = { fg = p.red, italic = true },
	["@variable.parameter"]   = { fg = p.gray_l, italic = true },
	["@variable.member"]      = { fg = p.gray },

	["@property"]             = { fg = p.gray },
	["@field"]                = { fg = p.gray },
	["@attribute"]            = { fg = p.mauve },

	["@type"]                 = { fg = p.teal },
	["@type.builtin"]         = { fg = p.teal, italic = true },
	["@type.definition"]      = { fg = p.teal },
	["@module"]               = { fg = p.mauve, italic = true },
	["@namespace"]            = { fg = p.mauve, italic = true },

	["@constant"]             = { fg = p.orange },
	["@constant.builtin"]     = { fg = p.orange, italic = true },
	["@constant.macro"]       = { fg = p.orange },
	["@number"]               = { fg = p.orange },
	["@number.float"]         = { fg = p.orange },
	["@boolean"]              = { fg = p.orange },

	["@operator"]             = { fg = p.gray_m },
	["@punctuation.delimiter"]= { fg = p.gray_m },
	["@punctuation.bracket"]  = { fg = p.gray_m },
	["@punctuation.special"]  = { fg = p.red },

	["@label"]                = { fg = p.violet },

	["@tag"]                  = { fg = p.violet },
	["@tag.builtin"]          = { fg = p.violet },
	["@tag.attribute"]        = { fg = p.teal, italic = true },
	["@tag.delimiter"]        = { fg = p.gray_m },

	["@markup.heading"]       = { fg = p.fg_hi, bold = true },
	["@markup.strong"]        = { fg = p.fg_hi, bold = true },
	["@markup.italic"]        = { fg = p.fg, italic = true },
	["@markup.strikethrough"] = { fg = p.gray_d, strikethrough = true },
	["@markup.link"]          = { fg = p.accent, underline = true },
	["@markup.link.label"]    = { fg = p.teal },
	["@markup.link.url"]      = { fg = p.gray_d, underline = true },
	["@markup.raw"]           = { fg = p.accent },
	["@markup.raw.block"]     = { fg = p.accent },
	["@markup.list"]          = { fg = p.violet },
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
	["@lsp.type.namespace"]     = { fg = p.mauve, italic = true },
	["@lsp.type.class"]         = { fg = p.teal },
	["@lsp.type.interface"]     = { fg = p.teal },
	["@lsp.type.enum"]          = { fg = p.teal },
	["@lsp.type.type"]          = { fg = p.teal },
	["@lsp.type.typeParameter"] = { fg = p.teal, italic = true },
	["@lsp.type.enumMember"]    = { fg = p.orange },
	["@lsp.type.function"]      = { fg = p.blue },
	["@lsp.type.method"]        = { fg = p.blue },
	["@lsp.type.keyword"]       = { fg = p.violet, italic = true },
	["@lsp.type.decorator"]     = { fg = p.mauve },
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
	BufferCurrentSign    = { fg = p.accent, bg = p.bg },
	BufferCurrentTarget  = { fg = p.accent_l, bg = p.bg, bold = true },
	BufferVisible        = { fg = p.gray_l, bg = p.bg_dim },
	BufferVisibleIndex   = { fg = p.gray_l, bg = p.bg_dim },
	BufferVisibleMod     = { fg = p.accent_d, bg = p.bg_dim },
	BufferVisibleSign    = { fg = p.gray_dd, bg = p.bg_dim },
	BufferVisibleTarget  = { fg = p.accent_l, bg = p.bg_dim, bold = true },
	BufferInactive       = { fg = p.gray_d, bg = p.bg_dim },
	BufferInactiveIndex  = { fg = p.gray_d, bg = p.bg_dim },
	BufferInactiveMod    = { fg = p.accent_d, bg = p.bg_dim },
	BufferInactiveSign   = { fg = p.gray_dd, bg = p.bg_dim },
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
	SnacksNormal          = { fg = p.fg, bg = p.bg_dim },
	SnacksWinBar          = { fg = p.fg_hi, bg = p.bg_dim },
	SnacksBackdrop        = { bg = p.bg },
	SnacksPickerDir       = { fg = p.gray_d },
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
