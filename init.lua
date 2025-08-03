-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true 

-- Make sure editorconfig is on always
vim.g.editorconfig = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false

-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true
vim.o.showmode = false

-- Enable some auto indent stuff
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.expandtab = true -- Tabs converted to spaces
vim.o.shiftwidth = 4

-- When a line gets broken then this will show the broke
-- line to be indented (basically line wrap indent)
vim.o.breakindent = true

-- set the tabstops
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- Show cursor line
vim.o.cursorline = true
-- Cursor settings
vim.opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- undo files
vim.o.undofile = true

-- User smart casing for search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false                           -- Don't highlight search results 
vim.o.incsearch = true  

-- Show the sign column (language server column with warning, etc.)
vim.o.signcolumn = "yes"


-- Splits should go right if vertical or bottom of horizontal
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Give us more room for the buffer view this makes it so
-- the command : mode shows at command
-- vim.o.cmdheight = 0

-- Show more context
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8

-- Clipboard config
vim.o.clipboard = "unnamedplus"

-- column for line length
vim.opt_local.colorcolumn = "90"

vim.o.winborder = "rounded"

-- Time for Key Mappings
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Oil toggle popup
vim.api.nvim_set_keymap( "n", "<leader>e", [[<cmd>lua require("oil").toggle_float()<CR>]], { noremap = true, silent = true, desc = "Toggle Oil float" } )

-- Debugger keymappings
vim.keymap.set('n', '<leader>db', ":DapToggleBreakpoint<CR>", { desc='Set a breakpoint', noremap=true })
vim.keymap.set('n', '<leader>dc', ":DapContinue<CR>", { desc='Continue or Run the program', noremap=true })
vim.keymap.set('n', '<F8>', ":DapStepOver<CR>", { desc='Step Over', noremap=true })
vim.keymap.set('n', '<F7>', ":DapStepInto<CR>", { desc='Step Into', noremap=true })
vim.keymap.set('n', '<F9>', ":DapContinue<CR>", { desc='Continue or Run the program', noremap=true })
vim.keymap.set('n', '<F19>', ":DapStepOut<CR>", { desc='Step Out', noremap=true })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", ":e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })


-- Now for plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      config=function()
          require("oil").setup()
      end,
      -- Optional dependencies
      dependencies = { { "echasnovski/mini.icons", opts={} }},
      -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
    },
    {
      'saghen/blink.cmp',
      -- optional: provides snippets for the snippet source
      dependencies = { 'rafamadriz/friendly-snippets' },

      -- use a release tag to download pre-built binaries
      version = '1.4.1',
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = 'default' },

        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = 'mono'
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = { documentation = { auto_show = false } },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust" }
      },
      {
          {
              'kristijanhusak/vim-dadbod-ui',
              dependencies = {
                  { 'tpope/vim-dadbod', lazy = true },
                  { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
              },
              cmd = {
                  'DBUI',
                  'DBUIToggle',
                  'DBUIAddConnection',
                  'DBUIFindBuffer',
              },
              init = function()
                  -- Your DBUI configuration
                  vim.g.db_ui_use_nerd_fonts = 1
              end,
          },
          { -- optional saghen/blink.cmp completion source
              'saghen/blink.cmp',
              opts = {
                  sources = {
                      default = { "lsp", "path", "snippets", "buffer" },
                      per_filetype = {
                          sql = { 'snippets', 'dadbod', 'buffer' },
                      },
                      -- add vim-dadbod-completion to your completion providers
                      providers = {
                          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                      },
                  },
              },
          },
      },
      opts_extend = { "sources.default" }
    },
    {
        "NicholasMata/nvim-dap-cs",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui"
        },
    },
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      -- dependencies = { "nvim-tree/nvim-web-devicons" },
      -- or if using mini.icons/mini.nvim
      dependencies = { "echasnovski/mini.icons" },
      opts = {}
    },
    {
        "neovim/nvim-lspconfig" 
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    -- import your plugins
    -- { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "cyberdream" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


vim.cmd("colorscheme cyberdream")


-- Turn on LSP
--
vim.lsp.enable('lua_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('pyright')
vim.lsp.enable('clangd')
vim.lsp.enable('omnisharp')
