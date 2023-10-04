---
-- Some sane defaults
---

vim.opt.number = true 
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

---
-- Make vim look nice
---

vim.opt.termguicolors = true
vim.cmd.colorscheme('palenight')

vim.opt.showmode = false

-- Misc
-- Disable automatic folding
-- vim.g.vim_markdown_folding_disabled = 1
-- Set folding level to heading 2
vim.g.vim_markdown_folding_level = 2

