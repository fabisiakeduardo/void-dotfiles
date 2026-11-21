-- Void-macOS-OLED — Native Neovim Colorscheme matching Ghostty, Fish, Tmux & VS Code
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "void-oled"

local c = {
  none     = "NONE",
  bg       = "#060608",
  bg_alt   = "#0c0c10",
  surface  = "#121216",
  border   = "#27272a",
  sel      = "#2c2018",
  muted    = "#52525b",
  subtle   = "#71717a",
  fg_dim   = "#a1a1aa",
  fg       = "#ededf0",
  white    = "#fafafa",
  amber    = "#ff8c38",
  amber_hi = "#ffb36b",
  gold     = "#fbbf24",
  red      = "#ff5f56",
  green    = "#34d399",
  blue     = "#60a5fa",
  purple   = "#c084fc",
  cyan     = "#38bdf8",
}

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Core UI (transparent over Ghostty glass!)
hi("Normal",          { fg = c.fg, bg = c.none })
hi("NormalNC",        { fg = c.fg_dim, bg = c.none })
hi("NormalFloat",     { fg = c.fg, bg = c.none })
hi("FloatBorder",     { fg = c.border, bg = c.none })
hi("FloatTitle",      { fg = c.amber, bg = c.none, bold = true })
hi("SignColumn",      { fg = c.muted, bg = c.none })
hi("EndOfBuffer",     { fg = c.bg_alt, bg = c.none })
hi("CursorLine",      { bg = c.surface })
hi("CursorLineNr",    { fg = c.amber, bold = true })
hi("LineNr",          { fg = c.muted })
hi("Visual",          { bg = c.sel })
hi("Search",          { fg = c.bg, bg = c.amber })
hi("IncSearch",       { fg = c.bg, bg = c.amber_hi, bold = true })
hi("CurSearch",       { fg = c.bg, bg = c.amber_hi, bold = true })
hi("MatchParen",      { fg = c.amber, bg = c.sel, bold = true })
hi("WinSeparator",    { fg = c.border, bg = c.none })
hi("VertSplit",       { fg = c.border, bg = c.none })
hi("StatusLine",      { fg = c.fg, bg = c.none })
hi("StatusLineNC",    { fg = c.muted, bg = c.none })
hi("TabLine",         { fg = c.subtle, bg = c.none })
hi("TabLineFill",     { bg = c.none })
hi("TabLineSel",      { fg = c.bg, bg = c.amber, bold = true })
hi("Pmenu",           { fg = c.fg, bg = c.bg_alt })
hi("PmenuSel",        { fg = c.white, bg = c.sel, bold = true })
hi("PmenuSbar",       { bg = c.bg_alt })
hi("PmenuThumb",      { bg = c.border })
hi("Folded",          { fg = c.subtle, bg = c.surface })
hi("NonText",         { fg = c.border })
hi("Whitespace",      { fg = c.border })
hi("Directory",       { fg = c.blue, bold = true })
hi("Title",           { fg = c.amber, bold = true })
hi("ErrorMsg",        { fg = c.red, bold = true })
hi("WarningMsg",      { fg = c.gold, bold = true })
hi("MoreMsg",         { fg = c.green })
hi("Question",        { fg = c.cyan })

-- Syntax
hi("Comment",         { fg = c.muted, italic = true })
hi("Constant",        { fg = c.gold })
hi("String",          { fg = c.green })
hi("Character",       { fg = c.green })
hi("Number",          { fg = c.amber_hi })
hi("Boolean",         { fg = c.amber })
hi("Float",           { fg = c.amber_hi })
hi("Identifier",      { fg = c.fg })
hi("Function",        { fg = c.blue })
hi("Statement",       { fg = c.purple, italic = true })
hi("Conditional",     { fg = c.purple, italic = true })
hi("Repeat",          { fg = c.purple, italic = true })
hi("Label",           { fg = c.amber })
hi("Operator",        { fg = c.amber })
hi("Keyword",         { fg = c.purple, italic = true })
hi("Exception",       { fg = c.red })
hi("PreProc",         { fg = c.cyan })
hi("Include",         { fg = c.purple })
hi("Define",          { fg = c.purple })
hi("Macro",           { fg = c.cyan })
hi("Type",            { fg = c.gold })
hi("StorageClass",    { fg = c.purple })
hi("Structure",       { fg = c.gold })
hi("Typedef",         { fg = c.gold })
hi("Special",         { fg = c.cyan })
hi("SpecialChar",     { fg = c.amber })
hi("Delimiter",       { fg = c.fg_dim })
hi("Underlined",      { underline = true })
hi("Todo",            { fg = c.bg, bg = c.amber, bold = true })

-- Treesitter
hi("@comment",              { link = "Comment" })
hi("@keyword",              { fg = c.purple, italic = true })
hi("@keyword.return",       { fg = c.purple, italic = true })
hi("@keyword.operator",     { fg = c.amber })
hi("@function",             { fg = c.blue })
hi("@function.builtin",     { fg = c.cyan })
hi("@function.method",      { fg = c.blue })
hi("@variable",             { fg = c.fg })
hi("@variable.builtin",     { fg = c.amber })
hi("@variable.parameter",   { fg = c.fg_dim })
hi("@property",             { fg = c.cyan })
hi("@field",                { fg = c.cyan })
hi("@string",               { fg = c.green })
hi("@number",               { fg = c.amber_hi })
hi("@boolean",              { fg = c.amber })
hi("@constant",             { fg = c.gold })
hi("@constant.builtin",     { fg = c.amber })
hi("@type",                 { fg = c.gold })
hi("@type.builtin",         { fg = c.gold })
hi("@operator",             { fg = c.amber })
hi("@punctuation.bracket",  { fg = c.fg_dim })
hi("@punctuation.delimiter",{ fg = c.subtle })
hi("@tag",                  { fg = c.amber })
hi("@tag.attribute",        { fg = c.blue })
hi("@tag.delimiter",        { fg = c.subtle })

-- Diagnostics & Git
hi("DiagnosticError",          { fg = c.red })
hi("DiagnosticWarn",           { fg = c.gold })
hi("DiagnosticInfo",           { fg = c.blue })
hi("DiagnosticHint",           { fg = c.cyan })
hi("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hi("DiagnosticUnderlineWarn",  { sp = c.gold, undercurl = true })
hi("DiagnosticUnderlineInfo",  { sp = c.blue, undercurl = true })
hi("DiagnosticUnderlineHint",  { sp = c.cyan, undercurl = true })
hi("GitSignsAdd",              { fg = c.green })
hi("GitSignsChange",           { fg = c.amber })
hi("GitSignsDelete",           { fg = c.red })
hi("DiffAdd",                  { fg = c.green, bg = "#0b241b" })
hi("DiffChange",               { fg = c.amber, bg = "#241910" })
hi("DiffDelete",               { fg = c.red, bg = "#291212" })

-- Telescope (transparent Void OLED)
hi("TelescopeNormal",        { fg = c.fg, bg = c.none })
hi("TelescopeBorder",        { fg = c.border, bg = c.none })
hi("TelescopePromptBorder",  { fg = c.amber, bg = c.none })
hi("TelescopePromptTitle",   { fg = c.bg, bg = c.amber, bold = true })
hi("TelescopeResultsTitle",  { fg = c.fg_dim, bg = c.none })
hi("TelescopePreviewTitle",  { fg = c.cyan, bg = c.none })
hi("TelescopeSelection",     { fg = c.white, bg = c.sel, bold = true })
hi("TelescopeMatching",      { fg = c.amber, bold = true })

-- Noice / Notify / WhichKey / Cmp
hi("WhichKey",              { fg = c.amber })
hi("WhichKeyGroup",         { fg = c.blue })
hi("WhichKeyDesc",          { fg = c.fg })
hi("WhichKeyBorder",        { fg = c.border, bg = c.none })
hi("CmpItemAbbrMatch",      { fg = c.amber, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = c.amber_hi, bold = true })
hi("CmpItemKindFunction",   { fg = c.blue })
hi("CmpItemKindVariable",   { fg = c.cyan })
hi("CmpItemKindKeyword",    { fg = c.purple })
hi("CmpItemKindSnippet",    { fg = c.green })
