return {
    'rmagatti/auto-session',
    config = function()
        local auto_session = require('auto-session')

        auto_session.setup({
            auto_restore = false,
            suppressed_dirs = {
                vim.fn.expand('~'),
                vim.fn.expand('~/Downloads'),
                vim.fn.expand('~/Documents'),
                vim.fn.expand('~/Desktop'),
            },
        })

        vim.keymap.set('n', '<leader>ws', function()
            auto_session.save_session()
        end, { desc = 'Save session' })

        vim.keymap.set('n', '<leader>wr', function()
            auto_session.restore_session()
        end, { desc = 'Restore session' })
    end,
}
