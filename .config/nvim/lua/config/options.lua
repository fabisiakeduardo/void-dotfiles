-- Craftzdog Options on top of LazyVim defaults
local opt = vim.opt

opt.scrolloff = 10
opt.cmdheight = 0
opt.wrap = false
opt.splitkeep = "cursor"
opt.backspace = { "start", "eol", "indent" }
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })
opt.winblend = 0
opt.pumblend = 0

-- Undercurl in Ghostty / Tmux
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
