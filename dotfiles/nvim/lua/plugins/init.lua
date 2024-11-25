return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "rust",
        "python",
        "ocaml",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
    },
    config = function()
      require "configs.treesitter"
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "tailwindcss-language-server",
        "typescript-language-server",
        "eslint-lsp",
        "ts-standard",
        "mypy",
        "ruff",
        "debugpy",
        "isort",
        "jinja-lsp",
        "pyright",
        "clangd",
        "clang-format",
        "cmake-language-server",
        "cmakelint",
        "cpplint",
        "cpptools",
        "dot-language-server",
        "dockerfile-language-server",
        "gitui",
        "hydra-lsp",
        "json-lsp",
        "json-lint",
        "yaml-language-server",
        "yamllint",
        "ocaml-lsp",
        "ocamlformat",
      },
    },
  },
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
  },
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "0.3.*",
    build = function()
      require("typst-preview").update()
    end,
  },
  {
    -- for lsp features in code cells / embedded code
    "jmbuhr/otter.nvim",
    dev = false,
    lazy = false,
    autostart = true,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    opts = {
      verbose = {
        no_code_found = false,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "configs.dap"
    end,
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require "configs.dap-ui"
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require "configs.dap-python"
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.mason-dap"
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lint"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    lazy = false,
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { -- nice loading notifications
        -- PERF: but can slow down startup
        "j-hui/fidget.nvim",
        -- enabled = false,
        opts = {},
      },
      {
        {
          "folke/lazydev.nvim",
          ft = "lua",
          opts = {
            library = {
              { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
          },
        },
        { -- optional completion source for require statements and module annotations
          "hrsh7th/nvim-cmp",
          lazy = false,
          opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
              name = "lazydev",
              group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
          end,
        },
      },
    },
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dev = false,
    opts = {},
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "epwalsh/obsidian.nvim",
    enabled = false,
    ft = "markdown",
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre " .. vim.fn.expand "~/notes/**/*.md",
      "BufNewFile " .. vim.fn.expand "~/notes/**/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>nd", ":ObsidianToday<cr>", desc = "obsidian [d]aily" },
      { "<leader>nt", ":ObsidianToday 1<cr>", desc = "obsidian [t]omorrow" },
      { "<leader>ny", ":ObsidianToday -1<cr>", desc = "obsidian [y]esterday" },
      { "<leader>nb", ":ObsidianBacklinks<cr>", desc = "obsidian [b]acklinks" },
      { "<leader>nl", ":ObsidianLink<cr>", desc = "obsidian [l]ink selection" },
      { "<leader>nf", ":ObsidianFollowLink<cr>", desc = "obsidian [f]ollow link" },
      { "<leader>nn", ":ObsidianNew<cr>", desc = "obsidian [n]ew" },
      { "<leader>ns", ":ObsidianSearch<cr>", desc = "obsidian [s]earch" },
      { "<leader>no", ":ObsidianQuickSwitch<cr>", desc = "obsidian [o]pen quickswitch" },
      { "<leader>nO", ":ObsidianOpen<cr>", desc = "obsidian [O]pen in app" },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("obsidian").setup {
        workspaces = {
          {
            name = "notes",
            path = "~/notes",
          },
        },
        mappings = {
          -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
          ["gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          -- create and toggle checkboxes
          ["<cr>"] = {
            action = function()
              local line = vim.api.nvim_get_current_line()
              if line:match "%s*- %[" then
                require("obsidian").util.toggle_checkbox()
              elseif line:match "%s*-" then
                vim.cmd [[s/-/- [ ]/]]
                vim.cmd.nohlsearch()
              end
            end,
            opts = { buffer = true },
          },
        },
        -- Optional, customize how names/IDs for new notes are created.
        note_id_func = function(title)
          -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
          -- In this case a note with the title 'My new note' will be given an ID that looks
          -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
          local suffix = ""
          if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          return tostring(os.time()) .. "-" .. suffix
        end,
      }

      vim.wo.conceallevel = 1
    end,
  },
  { -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    "GCBallesteros/jupytext.nvim",
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
        r = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
    },
  },

  { -- send code from python/r/qmd documets to a terminal or REPL
    -- like ipython, R, bash
    "jpalardy/vim-slime",
    lazy = false,
    dev = false,
    init = function()
      vim.b["quarto_is_python_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context "python"
      end

      vim.cmd [[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]]

      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = true
      vim.g.slime_python_ipython = 1
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true

      local function mark_terminal()
        local job_id = vim.b.terminal_job_id
        vim.print("job_id: " .. job_id)
      end

      local function set_terminal()
        vim.fn.call("slime#config", {})
      end
      vim.keymap.set("n", "<leader>cm", mark_terminal, { desc = "[m]ark terminal" })
      vim.keymap.set("n", "<leader>cs", set_terminal, { desc = "[s]et terminal" })
    end,
  },

  { -- paste an image from the clipboard or drag-and-drop
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    ft = { "markdown", "quarto", "latex" },
    opts = {
      default = {
        dir_path = "img",
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
    config = function(_, opts)
      require("img-clip").setup(opts)
      vim.keymap.set("n", "<leader>ii", ":PasteImage<cr>", { desc = "insert [i]mage from clipboard" })
    end,
  },

  { -- preview equations
    "jbyuki/nabla.nvim",
    keys = {
      { "<leader>qm", ':lua require"nabla".toggle_virt()<cr>', desc = "toggle [m]ath equations" },
    },
  },

  {
    "benlubas/molten-nvim",
    enabled = false,
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
    end,
    keys = {
      { "<leader>mi", ":MoltenInit<cr>", desc = "[m]olten [i]nit" },
      {
        "<leader>mv",
        ":<C-u>MoltenEvaluateVisual<cr>",
        mode = "v",
        desc = "molten eval visual",
      },
      { "<leader>mr", ":MoltenReevaluateCell<cr>", desc = "molten re-eval cell" },
    },
  },
  {
    "folke/which-key.nvim",
    enabled = true,
    config = function()
      require("which-key").setup {}
      require "mappings"
    end,
  },
  { -- highlight markdown headings and code blocks etc.
    "lukas-reineke/headlines.nvim",
    enabled = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("headlines").setup {
        quarto = {
          query = vim.treesitter.query.parse(
            "markdown",
            [[
                (fenced_code_block) @codeblock
                ]]
          ),
          codeblock_highlight = "CodeBlock",
          treesitter_language = "markdown",
        },
        markdown = {
          query = vim.treesitter.query.parse(
            "markdown",
            [[
                (fenced_code_block) @codeblock
                ]]
          ),
          codeblock_highlight = "CodeBlock",
        },
      }
    end,
  },
}
