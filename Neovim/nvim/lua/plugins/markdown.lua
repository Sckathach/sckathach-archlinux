return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function()
      vim.g.mkdp_theme = "light"
      vim.g.mkdp_browser = "/usr/bin/min-browser"
      vim.g.mkdp_open_to_the_world = 0
    end
  }
}
