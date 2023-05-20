local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-d>", ":bp|bd #<CR>", opts)
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)
keymap("t", "<C-d>", ":bp|bd #<CR>", opts)

-- Telescope
keymap("n", "<C-p>", "<CMD>lua require('plugins.telescope').project_files()<CR>", opts)
keymap("n", "<S-p>", "<CMD>Telescope live_grep hidden=true<CR>", opts)
keymap("n", "<leader>ff", "<CMD>lua require('plugins.telescope').all_files()<CR>", opts)
keymap("n", "<leader>fb",
  "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown(opts))<cr>",
  opts)

-- Tree
keymap("n", "<C-f>", ":NvimTreeToggle<CR>", opts)

-- Trouble
keymap("n", "<C-t>", ":TroubleToggle<cr>", opts)

-- Resize with arrows
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Buffers
keymap("n", "<Tab>", ":BufferNext<CR>", opts)
keymap("n", "gn", ":bn<CR>", opts)
keymap("n", "<S-Tab>", ":BufferPrevious<CR>", opts)
keymap("n", "gp", ":bp<CR>", opts)
keymap("n", "<S-q>", ":BufferClose!<CR>", opts)
keymap("n", "<C-q>", ":q<CR>", opts)

-- Move between barbar buffers
keymap("n", "<Space>1", ":BufferGoto 1<CR>", opts)
keymap("n", "<Space>2", ":BufferGoto 2<CR>", opts)
keymap("n", "<Space>3", ":BufferGoto 3<CR>", opts)
keymap("n", "<Space>4", ":BufferGoto 4<CR>", opts)
keymap("n", "<Space>5", ":BufferGoto 5<CR>", opts)
keymap("n", "<Space>6", ":BufferGoto 6<CR>", opts)
keymap("n", "<Space>7", ":BufferGoto 7<CR>", opts)
keymap("n", "<Space>8", ":BufferGoto 8<CR>", opts)
keymap("n", "<Space>9", ":BufferGoto 9<CR>", opts)
keymap("n", "<A-1>", ":BufferGoto 1<CR>", opts)
keymap("n", "<A-2>", ":BufferGoto 2<CR>", opts)
keymap("n", "<A-3>", ":BufferGoto 3<CR>", opts)
keymap("n", "<A-4>", ":BufferGoto 4<CR>", opts)
keymap("n", "<A-5>", ":BufferGoto 5<CR>", opts)
keymap("n", "<A-6>", ":BufferGoto 6<CR>", opts)
keymap("n", "<A-7>", ":BufferGoto 7<CR>", opts)
keymap("n", "<A-8>", ":BufferGoto 8<CR>", opts)
keymap("n", "<A-9>", ":BufferGoto 9<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Don't yank on delete char
keymap("n", "x", '"_x', opts)
keymap("n", "X", '"_X', opts)
keymap("v", "x", '"_x', opts)
keymap("v", "X", '"_X', opts)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', opts)

-- Save file by CTRL-S
keymap("n", "<C-s>", ":w!<CR>", opts)
keymap("i", "<C-s>", "<ESC> :w!<CR>", opts)

-- Make word uppercase
keymap("n", "<C-u>", "viwU<ESC>", opts)
keymap("i", "<C-u>", "<ESC>viwUi", opts)

-- Remove highlights
keymap("n", "<CR>", ":noh<CR><CR>", opts)


-- Terminal
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
keymap("i", "<Esc>", "<C-\\><C-n>", opts)

keymap("n", [[<c-\>]], ":term<CR>", opts)
keymap("i", [[<c-\>]], ":term<CR>", opts)
keymap("v", [[<c-\>]], ":term<CR>", opts)

-- LSP
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)
keymap("n", "gl", '<cmd>lua vim.diagnostic.open_float(opts)<CR>', opts)
keymap("n", "gi", "<cmd>lua require'telescope.builtin'.lsp_implementations()<CR>", opts)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
keymap("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded' }})<CR>", opts)
keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' }})<CR>", opts)
