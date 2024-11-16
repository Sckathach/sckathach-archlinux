require "nvchad.options"

vim.o.cursorlineopt = 'both' -- to enable cursorline!

vim.wo.relativenumber = true

-- don't ask about existing swap files
vim.opt.shortmess:append 'A'

-- smarter search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- add new filetypes
vim.filetype.add {
  extension = {
    ojs = 'javascript',
    tsx = 'typescript'
  },
}

-- Show errors on multiple lines 
vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a) return a.isPreferred end,
    apply = true
  })
end
vim.keymap.set('n', '<leader>qf', quickfix, { noremap = true, silent = true })


