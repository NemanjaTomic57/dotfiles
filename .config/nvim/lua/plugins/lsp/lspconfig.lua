return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        { 'antosha417/nvim-lsp-file-operations', config = true },
        { 'folke/neodev.nvim',                   optis = {} },
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                -- keymaps
                opts.desc = 'Show LSP references'
                vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)    -- show definition, references 

                opts.desc = 'Go to declaration'
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = 'Show LSP definitions'
                vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)   -- show lsp definitions 

                opts.desc = 'Show LSP implementations'
                vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)   -- show lsp implementations 

                opts.desc = 'Show LSP type definitions'
                vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)  -- show lsp type definitions 

                opts.desc = 'See available code actions'
                vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)  -- see available code actions 

                opts.desc = 'Smart rename'
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = 'Show buffer diagnostics'
                vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)    -- show diagnostics for file 

                opts.desc = 'Show line diagnostics'
                vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)  -- show diagnostics for line

                opts.desc = 'Show documentation for what is under cursor'
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)   -- show documentation for what is under cursor

                opts.desc = 'Restart LSP'
                vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)

                vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
            end,
        })

        -- Define sign icons for each severity
        local signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
            [vim.diagnostic.severity.INFO]  = " ",
        }

        -- Set the diagnostic config with all icons
        vim.diagnostic.config({
            signs = {
                text = signs -- Enable signs in the gutter
            },
            -- virtual_text = true,  -- Specify Enable virtual text for diagnostics
            -- underline = true,     -- Specify Underline diagnostics
            -- update_in_insert = false,  -- Keep diagnostics active in insert mode
        })




        local lspconfig = require('lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        local capabilities = cmp_nvim_lsp.default_capabilities()    -- used to enable autocompletion

        -- Config lsp servers here
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    -- make the language server recognize 'vim' global
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    completion = {
                        callSnippet = 'Replace',
                    },
                    workspace = {
                        -- make language server aware of run time files 
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.stdpath('config') .. '/lua'] = true,
                        },
                    },
                },
            },
        })
        lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = {
                'html',
                'typescriptreact',
                'javascriptreact',
                'css',
                'sass',
                'scss',
                'less',
                'svelte',
            },
        })
        lspconfig.emmet_language_server.setup({
            filetypes = {
                'css',
                'eruby',
                'html',
                'javascript',
                'javascriptreact',
                'less',
                'sass',
                'scss',
                'pug',
                'typescriptreact'
            },
            -- Read more about this option in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
            -- **Note:** only the options listed in the table are supported
            init_options = {
                includeLanguages = {},
                excludeLanguages = {},
                extensionPath = {},
                preferences = {},
                showAbbreviationSuggestions = true,
                showExpandedAbbreviations = true,
                showSuggestionsAsSnippets = false,
                syntaxProfiles = {},
                variables = {},
            },
        })
        -- lspconfig.denols.setup({
        --     capabilities = capabilities,
        --     root_dir = lspconfig.utils.root_pattern('deno.json', 'deno.jsonc'), -- Atach only if these files exist
        -- })
        lspconfig.ts_ls.setup({
            capabilities = capabilities,
            root_dir = function(fname)
                -- Use tsserver unless a Deno-specific config is present
                local util = lspconfig.uitl
                return not util.root_pattern('deno.json', 'deno.jsonc')(fname)
                    and util.root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git')(fname)
            end,
            single_file_support = false,
            init_options = {
                preferences = {
                    includeCompletionsWithSnippetText = true,
                    includeCompletionsForImportStatements = true,
                },
            },
        })
    end
}
