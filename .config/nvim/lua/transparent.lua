local config = {
  enable = false,
  groups = {
    "Normal",
    "NormalNC",
    "Comment",
    "Constant",
    "Special",
    "Identifier",
    "Statement",
    "PreProc",
    "Type",
    "Underlined",
    "Todo",
    "String",
    "Function",
    "Conditional",
    "Repeat",
    "Operator",
    "Structure",
    "LineNr",
    "NonText",
    "SignColumn",
    "CursorLineNr",
    "EndOfBuffer",
  },
  extra_groups = "all",
  exclude = {},
}

local clear_group_bg = function(group, highlights)
  if not (group or highlights) then
    return
  end

  if group and vim.fn.highlight_exists(group) == 0 then
    return
  end

  group = group or vim.split(highlights, " ")[1]
  highlights = highlights or vim.api.nvim_exec("hi " .. group, true)

  if vim.tbl_contains(config.exclude, group) or highlights:match("links to") then
    return
  end

  vim.cmd(string.format("hi %s ctermbg=NONE guibg=NONE", group))
end

for _, group in ipairs(config.groups) do
  clear_group_bg(group)
end

if type(config.extra_groups) == "string" then
  if config.extra_groups == "all" then
    local hls = vim.split(vim.api.nvim_exec("highlight", true), "\n")
    for _, hl in ipairs(hls) do
      if not string.find(string.lower(hl), 'select') and
          not string.find(string.lower(hl), 'visual') and
          not string.find(string.lower(hl), 'cursorline') and
          not string.find(string.lower(hl), 'nc') and
          not string.find(string.lower(hl), 'shadow') and
          true
      then
        clear_group_bg(nil, hl)
      end
    end
  else
    clear_group_bg(config.extra_groups)
  end
else
  for _, group in ipairs(config.extra_groups) do
    clear_group_bg(group)
  end
end
