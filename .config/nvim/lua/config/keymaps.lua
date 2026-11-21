-- Craftzdog Signature Keymaps on top of LazyVim
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Fast escape
keymap.set("i", "jk", "<Esc>", opts)

-- Do not yank with x
keymap.set("n", "x", '"_x', opts)

-- Increment / decrement
keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "-", "<C-x>", opts)

-- Delete a word backwards (Craftzdog)
keymap.set("n", "dw", 'vb"_d', opts)

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", opts)

-- Tabs (Craftzdog)
keymap.set("n", "te", ":tabedit<CR>", opts)
keymap.set("n", "<Tab>", ":tabnext<CR>", opts)
keymap.set("n", "<S-Tab>", ":tabprev<CR>", opts)

-- Splits (Craftzdog)
keymap.set("n", "ss", ":split<Return><C-w>w", opts)
keymap.set("n", "sv", ":vsplit<Return><C-w>w", opts)
keymap.set("n", "sh", "<C-w>h", opts)
keymap.set("n", "sk", "<C-w>k", opts)
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "sl", "<C-w>l", opts)

-- Resize windows
keymap.set("n", "<C-w><left>", "<C-w><", opts)
keymap.set("n", "<C-w><right>", "<C-w>>", opts)
keymap.set("n", "<C-w><up>", "<C-w>+", opts)
keymap.set("n", "<C-w><down>", "<C-w>-", opts)

-- Craftzdog quick pickers wired to LazyVim's native Snacks picker
keymap.set("n", ";f", function() Snacks.picker.files() end, { desc = "Find Files (Craftzdog)" })
keymap.set("n", ";r", function() Snacks.picker.grep() end, { desc = "Live Grep (Craftzdog)" })
keymap.set("n", "\\\\", function() Snacks.picker.buffers() end, { desc = "Buffers (Craftzdog)" })
keymap.set("n", "sf", function() Snacks.explorer() end, { desc = "File Explorer (Craftzdog)" })
