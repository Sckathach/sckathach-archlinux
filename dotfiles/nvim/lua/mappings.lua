require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local ms = vim.lsp.protocol.Methods

vim.g["quarto_is_r_mode"] = nil
vim.g["reticulate_running"] = false

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local nmap = function(key, effect)
  vim.keymap.set("n", key, effect, { silent = true, noremap = true })
end

local vmap = function(key, effect)
  vim.keymap.set("v", key, effect, { silent = true, noremap = true })
end

local imap = function(key, effect)
  vim.keymap.set("i", key, effect, { silent = true, noremap = true })
end

-- keep selection after indent/dedent
vmap(">", ">gv")
vmap("<", "<gv")

local function send_cell()
  if vim.b["quarto_is_r_mode"] == nil then
    vim.fn["slime#send_cell"]()
    return
  end
  if vim.b["quarto_is_r_mode"] == true then
    vim.g.slime_python_ipython = 0
    local is_python = require("otter.tools.functions").is_otter_language_context "python"
    if is_python and not vim.b["reticulate_running"] then
      vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
      vim.b["reticulate_running"] = true
    end
    if not is_python and vim.b["reticulate_running"] then
      vim.fn["slime#send"]("exit" .. "\r")
      vim.b["reticulate_running"] = false
    end
    vim.fn["slime#send_cell"]()
  end
end

--- Send code to terminal with vim-slime
--- If an R terminal has been opend, this is in r_mode
--- and will handle python code via reticulate when sent
--- from a python chunk.
local slime_send_region_cmd = ":<C-u>call slime#send_op(visualmode(), 1)<CR>"
slime_send_region_cmd = vim.api.nvim_replace_termcodes(slime_send_region_cmd, true, false, true)
local function send_region()
  -- if filetyps is not quarto, just send_region
  if vim.bo.filetype ~= "quarto" or vim.b["quarto_is_r_mode"] == nil then
    vim.cmd("normal" .. slime_send_region_cmd)
    return
  end
  if vim.b["quarto_is_r_mode"] == true then
    vim.g.slime_python_ipython = 0
    local is_python = require("otter.tools.functions").is_otter_language_context "python"
    if is_python and not vim.b["reticulate_running"] then
      vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
      vim.b["reticulate_running"] = true
    end
    if not is_python and vim.b["reticulate_running"] then
      vim.fn["slime#send"]("exit" .. "\r")
      vim.b["reticulate_running"] = false
    end
    vim.cmd("normal" .. slime_send_region_cmd)
  end
end

-- send code with ctrl+Enter
-- just like in e.g. RStudio
-- needs kitty (or other terminal) config:
-- map shift+enter send_text all \x1b[13;2u
-- map ctrl+enter send_text all \x1b[13;5u
nmap("<c-cr>", send_cell)
nmap("<s-cr>", send_cell)
imap("<c-cr>", send_cell)
imap("<s-cr>", send_cell)

local function toggle_light_dark_theme()
  if vim.o.background == "light" then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end

local function new_terminal(lang)
  vim.cmd("vsplit term://" .. lang)
end

local function new_terminal_python()
  new_terminal "python"
end
local function new_terminal_ipython()
  new_terminal "ipython --no-confirm-exit"
end

-- normal mode
map("n", "<esc>", "<cmd>noh<cr>", { desc = "remove search highlight" })
map("n", "[q", ":silent cprev<cr>", { desc = "[q]uickfix prev" })
map("n", "]q", ":silent cnext<cr>", { desc = "[q]uickfix next" })

-- visual mode
map("v", ".", ":norm .<cr>", { desc = "repat last normal mode command" })
map("v", "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z", { desc = "move line down" })
map("v", "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", { desc = "move line up" })
map("v", "<cr>", send_region, { desc = "run code region" })
map("v", "q", ":norm @q<cr>", { desc = "repat q macro" })

local function get_otter_symbols_lang()
  local otterkeeper = require "otter.keeper"
  local main_nr = vim.api.nvim_get_current_buf()
  local langs = {}
  for i, l in ipairs(otterkeeper.rafts[main_nr].languages) do
    langs[i] = i .. ": " .. l
  end
  -- promt to choose one of langs
  local i = vim.fn.inputlist(langs)
  local lang = otterkeeper.rafts[main_nr].languages[i]
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
    otter = {
      lang = lang,
    },
  }
  -- don't pass a handler, as we want otter to use it's own handlers
  vim.lsp.buf_request(main_nr, ms.textDocument_documentSymbol, params, nil)
end

vim.keymap.set("n", "<leader>os", get_otter_symbols_lang, { desc = "otter [s]ymbols" })

-- normal mode with <leader>
map("n", "<leader><cr>", send_cell, { desc = "run code cell" })
map("n", "<leader>ci", new_terminal_ipython, { desc = "new [i]python terminal" })
map("n", "<leader>cp", new_terminal_python, { desc = "new [p]ython terminal" })
map("n", "<leader>f<space>", "<cmd>Telescope buffers<cr>", { desc = "[ ] buffers" })
map("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "git [c]ommits" })
map("n", "<leader>fd", "<cmd>Telescope buffers<cr>", { desc = "[d] buffers" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "[g]rep" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "[h]elp" })
map("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "[j]umplist" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "[k]eymaps" })
map("n", "<leader>fl", "<cmd>Telescope loclist<cr>", { desc = "[l]oclist" })
map("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "[q]uickfix" })
map("n", "<leader>gdc", ":DiffviewClose<cr>", { desc = "[c]lose" })
map("n", "<leader>gdo", ":DiffviewOpen<cr>", { desc = "[o]pen" })
map("n", "<leader>gs", ":Gitsigns<cr>", { desc = "git [s]igns" })
map(
  "n",
  "<leader>gwc",
  ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
  { desc = "worktree create" }
)
map(
  "n",
  "<leader>gws",
  ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
  { desc = "worktree switch" }
)
map("n", "<leader>qE", function()
  require("otter").export(true)
end, { desc = "[E]xport with overwrite" })
map("n", "<leader>qa", ":QuartoActivate<cr>", { desc = "[a]ctivate" })
map("n", "<leader>qe", require("otter").export, { desc = "[e]xport" })
map("n", "<leader>qh", ":QuartoHelp ", { desc = "[h]elp" })
map("n", "<leader>qp", ":lua require'quarto'.quartoPreview()<cr>", { desc = "[p]review" })
map("n", "<leader>qq", ":lua require'quarto'.quartoClosePreview()<cr>", { desc = "[q]uiet preview" })
map("n", "<leader>qra", ":QuartoSendAll<cr>", { desc = "run [a]ll" })
map("n", "<leader>qrb", ":QuartoSendBelow<cr>", { desc = "run [b]elow" })
map("n", "<leader>qrr", ":QuartoSendAbove<cr>", { desc = "to cu[r]sor" })
map("n", "<leader>tt", toggle_light_dark_theme, { desc = "[t]oggle light/dark theme" })
