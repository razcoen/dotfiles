-- local catppuccin = require('catppuccin')
-- catppuccin.setup()

-- require("github-theme").setup({
--   comment_style = "NONE",
--   keyword_style = "NONE",
-- })
--

-- vim.g.catppuccin_flavour = "frappe"
local colorscheme = "github_dark_default"
vim.cmd(string.format("colorscheme %s", colorscheme))

require("transparent")

vim.api.nvim_exec("highlight! Search guifg=Yellow gui=bold", false)
-- vim.api.nvim_set_hl('TelescopeSelection', { guibg = "#374247", gui = "bold" }, false);

-- Errors
vim.api.nvim_exec("highlight! LspDiagnosticsVirtualTextError guifg=Red gui=bold", false)
vim.api.nvim_exec("highlight! DiagnosticVirtualTextError guifg=Red gui=bold", false)

-- Warnings
vim.api.nvim_exec("highlight! LspDiagnosticsVirtualTextWarning guifg=Yellow", false)
vim.api.nvim_exec("highlight! DiagnosticVirtualTextWarn guifg=Yellow", false)

-- Info & Hints
vim.api.nvim_exec("highlight! DiagnosticVirtualTextInfo guifg=White", false)
vim.api.nvim_exec("highlight! DiagnosticVirtualTextHint guifg=White", false)

-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
-- completion colors
-- gray
vim.api.nvim_exec("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080", true)
-- blue
vim.api.nvim_exec("highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6", true)
vim.api.nvim_exec("highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6", true)
-- light blue
vim.api.nvim_exec("highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE", true)
vim.api.nvim_exec("highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE", true)
vim.api.nvim_exec("highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE", true)
-- pink
vim.api.nvim_exec("highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0", true)
vim.api.nvim_exec("highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0", true)
-- front
vim.api.nvim_exec("highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4", true)
vim.api.nvim_exec("highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4", true)
vim.api.nvim_exec("highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4", true)


-- barbar colors (with dracula)
if colorscheme == "dracula" then
  vim.api.nvim_exec("highlight! BufferCurrentMod guifg=#ff79c6", true) -- pink
  vim.api.nvim_exec("highlight! BufferVisibleMod guifg=#fffff", true) -- white
  -- vim.api.nvim_exec("highlight! BufferInactiveMod guifg=#89b8c3", true) -- light blue
  vim.api.nvim_exec("highlight! BufferInactiveMod guifg=#d070a0", true) -- light pink
end
