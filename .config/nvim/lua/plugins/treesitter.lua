return{
    {
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufReadPre', 'BufNewFile' },
        build = ':TSUpdate',
        config = function()
            -- import nvim-treesitter plugin
            local treesitter = require('nvim-treesitter.configs')

            -- configure treesitter
            treesitter.setup({
                highlight = {
                    enable = true,
                },
                -- enable indentation
                indent = { enable = true },
                -- ensure these languages parsers are installed
                ensure_installed = {
                    'json',
                    'javascript',
                    'typescript',
                    'tsx',
                    'yaml',
                    'html',
                    'css',
                    'python',
                    'http',
                    'markdown',
                    'markdown_inline',
                    'bash',
                    'lua',
                    'vim',
                    'dockerfile',
                    'gitignore',
                    'query',
                    'vimdoc',
                    'c',
                    'c_sharp',
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<C-space>',
                        node_incremental = '<C-space>',
                        scope_incremental = false,
                    },
                },
                additional_vim_regex_highlighting = false,
            })
        end,
    }
}
