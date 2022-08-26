local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("lsp.installer")
require("lsp.handlers").setup()

require'lsp_extensions'.inlay_hints{
	highlight = "Comment",
	prefix = " > ",
	aligned = false,
	only_current_line = false,
	enabled = { "TypeHint", "ChainingHint", "ParameterHint" }
}
