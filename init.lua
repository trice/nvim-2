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
vim.opt.guicursor =
"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- undo files
vim.o.undofile = true

-- User smart casing for search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false -- Don't highlight search results
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
vim.api.nvim_set_keymap("n", "<leader>e", [[<cmd>lua require("oil").toggle_float()<CR>]],
    { noremap = true, silent = true, desc = "Toggle Oil float" })



-- Show a diagnostic float with the diagnostic Warning, Error, Information
vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, { desc = 'Open diagnostic message float' })

-- Debugger keymappings
vim.keymap.set('n', '<leader>db', ":DapToggleBreakpoint<CR>", { desc = 'Set a breakpoint', noremap = true })
vim.keymap.set('n', '<leader>dc', ":DapContinue<CR>", { desc = 'Continue or Run the program', noremap = true })
vim.keymap.set('n', '<F8>', ":DapStepOver<CR>", { desc = 'Step Over', noremap = true })
vim.keymap.set('n', '<F7>', ":DapStepInto<CR>", { desc = 'Step Into', noremap = true })
vim.keymap.set('n', '<F9>', ":DapContinue<CR>", { desc = 'Continue or Run the program', noremap = true })
vim.keymap.set('n', '<F19>', ":DapStepOut<CR>", { desc = 'Step Out', noremap = true })

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

-- Quick file format from LSP
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)


-- Now for plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
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
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        {
            "scottmckendry/cyberdream.nvim",
            lazy = false,
            priority = 1000,
        },
        {
            'stevearc/oil.nvim',
            ---@module 'oil'
            ---@type oil.SetupOpts
            config = function()
                require("oil").setup()
            end,
            -- Optional dependencies
            dependencies = { { "echasnovski/mini.icons", opts = {} } },
            -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
            -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
            lazy = false,
        },
        {
            'saghen/blink.cmp',
            -- optional: provides snippets for the snippet source
            dependencies = { 'rafamadriz/friendly-snippets' },
            build = 'cargo +nightly build --release',
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

                build = 'cargo build --release',
                fuzzy = { implementation = "prefer_rust" }
            },
            {
                {
                    'kristijanhusak/vim-dadbod-ui',
                    dependencies = {
                        { 'tpope/vim-dadbod',                     lazy = true },
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
            "neovim/nvim-lspconfig",
            dependencies = { 'saghen/blink.cmp' },

            -- example using `opts` for defining servers
            opts = {
                servers = {
                    lua_ls = {}
                }
            },
            config = function(_, opts)
                local lspconfig = require('lspconfig')
                for server, config in pairs(opts.servers) do
                    -- passing config.capabilities to blink.cmp merges with the capabilities in your
                    -- `opts[server].capabilities, if you've defined it
                    config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                    lspconfig[server].setup(config)
                end
            end
        },
        {
            "mason-org/mason.nvim",
            opts = {}
        },
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
            config = function()
                local dap = require("dap")
                local dapui = require("dapui")
                dapui.setup()
                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open()
                end
                dap.listeners.after.event_terminated["dapui_config"] = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close()
                end
            end
        },
        {
            "NicholasMata/nvim-dap-cs",
            dependencies = {
                "mfussenegger/nvim-dap",
                "rcarriga/nvim-dap-ui"
            },
        },
        {
            "leoluz/nvim-dap-go",
            dependencies = {
                "mfussenegger/nvim-dap",
                "rcarriga/nvim-dap-ui"
            },
        },
        {
            "mfussenegger/nvim-dap-python",
            ft = "python",
            dependencies = {
                "mfussenegger/nvim-dap",
                "rcarriga/nvim-dap-ui"
            },
            config = function()
                local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
                require("dap-python").setup(path)
            end

        },
        {
            'echasnovski/mini.icons',
            version = '*',
            opts = {
                style = 'glyph'
            }
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                local configs = require("nvim-treesitter.configs")

                configs.setup({
                    ensure_installed = {
                        "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "c_sharp", "cpp",
                        "python", "cmake", "csv"
                    },
                    sync_install = false,
                    highlight = { enable = true },
                    indent = { enable = true },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = "<Enter>", -- set to `false` to disable one of the mappings
                            node_incremental = "<Enter>",
                            scope_incremental = false,
                            node_decremental = "<Backspace>",
                        },
                    }
                })
            end
        },
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            dependencies = {
                "nvim-treesitter/nvim-treesitter"
            },
            init = function()
                local config = require 'nvim-treesitter.configs'
                config.setup({
                    textobjects = {
                        select = {
                            enable = true,

                            -- Automatically jump forward to textobj, similar to targets.vim
                            lookahead = true,

                            keymaps = {
                                -- You can use the capture groups defined in textobjects.scm
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["ac"] = "@class.outer",
                                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                                -- nvim_buf_set_keymap) which plugins like which-key display
                                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                                -- You can also use captures from other query groups like `locals.scm`
                                ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                            },
                            -- You can choose the select mode (default is charwise 'v')
                            --
                            -- Can also be a function which gets passed a table with the keys
                            -- * query_string: eg '@function.inner'
                            -- * method: eg 'v' or 'o'
                            -- and should return the mode ('v', 'V', or '<c-v>') or a table
                            -- mapping query_strings to modes.
                            selection_modes = {
                                ['@parameter.outer'] = 'v', -- charwise
                                ['@function.outer'] = 'V',  -- linewise
                                ['@class.outer'] = '<c-v>', -- blockwise
                            },
                            -- If you set this to `true` (default is `false`) then any textobject is
                            -- extended to include preceding or succeeding whitespace. Succeeding
                            -- whitespace has priority in order to act similarly to eg the built-in
                            -- `ap`.
                            --
                            -- Can also be a function which gets passed a table with the keys
                            -- * query_string: eg '@function.inner'
                            -- * selection_mode: eg 'v'
                            -- and should return true or false
                            include_surrounding_whitespace = true,
                        },
                    },
                })
            end
        },
        -- import your plugins
        -- { import = "plugins" },
    },
    {
        'echasnovski/mini.statusline',
        version = false,
        opts = {}
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "cyberdream" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    } or {},
    virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
}

require("cyberdream").setup({
    -- Set light or dark variant
    variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`

    -- Enable transparent background
    transparent = false,

    -- Reduce the overall saturation of colours for a more muted look
    saturation = 1, -- accepts a value between 0 and 1. 0 will be fully desaturated (greyscale) and 1 will be the full color (default)

    -- Enable italics comments
    italic_comments = false,

    -- Replace all fillchars with ' ' for the ultimate clean look
    hide_fillchars = false,

    -- Apply a modern borderless look to pickers like Telescope, Snacks Picker & Fzf-Lua
    borderless_pickers = false,

    -- Set terminal colors used in `:terminal`
    terminal_colors = true,

    -- Improve start up time by caching highlights. Generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
    cache = false,

    -- Override highlight groups with your own colour values
    highlights = {
        -- Highlight groups to override, adding new groups is also possible
        -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

        -- Example:
        Comment = { fg = "#696969", bg = "NONE", italic = true },

        -- More examples can be found in `lua/cyberdream/extensions/*.lua`
    },

    -- Override a highlight group entirely using the built-in colour palette
    overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
        -- Example:
        return {
            Comment = { fg = colors.green, bg = "NONE", italic = true },
            ["@property"] = { fg = colors.magenta, bold = true },
        }
    end,

    -- Override colors
    colors = {
        -- For a list of colors see `lua/cyberdream/colours.lua`

        -- Override colors for both light and dark variants
        bg = "#000000",
        green = "#00ff00",

        -- If you want to override colors for light or dark variants only, use the following format:
        dark = {
            magenta = "#ff00ff",
            fg = "#eeeeee",
        },
        light = {
            red = "#ff5c57",
            cyan = "#5ef1ff",
        },
    },

    -- Disable or enable colorscheme extensions
    extensions = {
        telescope = true,
        notify = true,
        mini = true,
        ...
    },
})
vim.cmd("colorscheme cyberdream")


-- Turn on LSP
--
vim.lsp.enable('lua_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('pyright')
vim.lsp.enable('clangd')
vim.lsp.enable('omnisharp')

-- Must come after everything I guess
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Telescope help tags' })
