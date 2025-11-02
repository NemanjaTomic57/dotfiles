return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
        },
        config = function()
            vim.cmd.colorscheme 'tokyonight'
        end,
    },
    -- {
    --     'catppuccin/nvim',
    --     name = 'mocha',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd.colorscheme 'catppuccin-macchiato'
    --     end,
    -- },
}
