local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-d>", ":bp|bd #<CR>", opts)

-- Telescope
keymap("n", "<C-p>", "<CMD>lua require('plugins.telescope').project_files()<CR>", { noremap = true })
keymap("n", "<S-p>", "<CMD>Telescope live_grep hidden=true<CR>", { noremap = true })
keymap("n", "<leader>ff", "<CMD>lua require('plugins.telescope').all_files()<CR>", { noremap = true })
keymap("n", "<leader>fb",
  "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
  opts)

-- Tree
keymap("n", "<C-f>", ":NvimTreeToggle<CR>", opts)

-- Trouble
keymap("n", "<C-t>", ":TroubleToggle<cr>", opts)

-- -- Floaterm
-- keymap("n", "<C-\\>", ":FloatermToggle<cr>", opts)
-- keymap("t", "<Esc>", "<C-\\><C-n>", opts)
-- keymap("t","<C-\\>","<C-\\><C-n>:FloatermToggle<CR>", opts)
-- keymap("t","<C-n>","<C-\\><C-n>:FloatermNew<CR>", opts)
-- keymap("t","<C-q>","<C-\\><C-n>:FloatermKill<CR>", opts)
-- keymap("t","<C-k>","<C-\\><C-n>:FloatermNext<CR>", opts)
-- keymap("t","<C-j>","<C-\\><C-n>:FloatermPrev<CR>", opts)
-- vim.api.nvim_exec(
-- [[
-- let g:floaterm_width = 0.9
-- let g:floaterm_height = 0.7
-- ]], true)

-- Resize with arrows
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Buffers
keymap("n", "<Tab>", ":BufferNext<CR>", { noremap = true, silent = true })
keymap("n", "gn", ":bn<CR>", { noremap = true, silent = true })
keymap("n", "<S-Tab>", ":BufferPrevious<CR>", { noremap = true, silent = true })
keymap("n", "gp", ":bp<CR>", { noremap = true, silent = true })
keymap("n", "<S-q>", ":BufferClose!<CR>", { noremap = true, silent = true })
keymap("n", "<C-q>", ":q<CR>", { noremap = true, silent = true })

-- Move between barbar buffers
keymap("n", "<Space>1", ":BufferGoto 1<CR>", { silent = true })
keymap("n", "<Space>2", ":BufferGoto 2<CR>", { silent = true })
keymap("n", "<Space>3", ":BufferGoto 3<CR>", { silent = true })
keymap("n", "<Space>4", ":BufferGoto 4<CR>", { silent = true })
keymap("n", "<Space>5", ":BufferGoto 5<CR>", { silent = true })
keymap("n", "<Space>6", ":BufferGoto 6<CR>", { silent = true })
keymap("n", "<Space>7", ":BufferGoto 7<CR>", { silent = true })
keymap("n", "<Space>8", ":BufferGoto 8<CR>", { silent = true })
keymap("n", "<Space>9", ":BufferGoto 9<CR>", { silent = true })
keymap("n", "<A-1>", ":BufferGoto 1<CR>", { silent = true })
keymap("n", "<A-2>", ":BufferGoto 2<CR>", { silent = true })
keymap("n", "<A-3>", ":BufferGoto 3<CR>", { silent = true })
keymap("n", "<A-4>", ":BufferGoto 4<CR>", { silent = true })
keymap("n", "<A-5>", ":BufferGoto 5<CR>", { silent = true })
keymap("n", "<A-6>", ":BufferGoto 6<CR>", { silent = true })
keymap("n", "<A-7>", ":BufferGoto 7<CR>", { silent = true })
keymap("n", "<A-8>", ":BufferGoto 8<CR>", { silent = true })
keymap("n", "<A-9>", ":BufferGoto 9<CR>", { silent = true })

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Don't yank on delete char
keymap("n", "x", '"_x', { noremap = true, silent = true })
keymap("n", "X", '"_X', { noremap = true, silent = true })
keymap("v", "x", '"_x', { noremap = true, silent = true })
keymap("v", "X", '"_X', { noremap = true, silent = true })

-- Don't yank on visual paste
keymap("v", "p", '"_dP', { noremap = true, silent = true })

-- Save file by CTRL-S
keymap("n", "<C-s>", ":w!<CR>", { noremap = true, silent = true })
keymap("i", "<C-s>", "<ESC> :w!<CR>", { noremap = true, silent = true })

-- Make word uppercase
keymap("n", "<C-u>", "viwU<ESC>", { noremap = true })
keymap("i", "<C-u>", "<ESC>viwUi", { noremap = true })

-- Remove highlights
keymap("n", "<CR>", ":noh<CR><CR>", { noremap = true, silent = true })


-- Terminal
keymap("n", [[<c-\>]], ":term<CR>", { silent = true })
keymap("i", [[<c-\>]], ":term<CR>", { silent = true })
keymap("v", [[<c-\>]], ":term<CR>", { silent = true })
