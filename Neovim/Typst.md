# Neovim Typst Preview 

Original URL: https://github.com/chomosuke/typst-preview.nvim

Final config: 
```lua
-- init.lua 

require("typst-preview").setup({
  open_cmd = "min-browser %s -P typst-preview --class typst-preview"
})
```

```lua
-- plugins

{
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    version = '0.3.*',
    build = function() require 'typst-preview'.update() end,
},
```

## Add LSP with Mason
```
:MasonInstall typst-lsp
```

