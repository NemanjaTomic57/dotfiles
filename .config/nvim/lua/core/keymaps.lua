local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Clipboard things
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without replacing clipboard content" })

vim.keymap.set("v", "p", '"_dp', opts)

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "x", '"_x', opts)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")    -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>")  -- close current tab
vim.keymap.set("n", "<Tab>", "<cmd>tabn<CR>")      -- go to next
vim.keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>")      -- go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>")  -- open current tab in new tab

-- split
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

vim.keymap.set('n', '<C-j>', '<c-w>j', { desc = 'move to bottom split window'})
vim.keymap.set('n', '<C-k>', '<c-w>k', { desc = 'move to top split window'})
vim.keymap.set('n', '<C-l>', '<c-w>l', { desc = 'move to right split window'})
vim.keymap.set('n', '<C-h>', '<c-w>h', { desc = 'move to left split window'})

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
    -- Get the file path relative to the home directory
    local filePath = vim.fn.expand("%:~")
    -- Copy the file path to the clipboard register
    vim.fn.setreg("+", filePath)
    print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- Toggle LSP diagnostics visibility
local isLspDianosticsVisible = true
vim.keymap.set('n', '<leader>lx', function()
    isLspDianosticsVisible = not isLspDianosticsVisible
    vim.diagnostic.config({
        virtual_text = isLspDianosticsVisible,
        underline = isLspDianosticsVisible
    })
end, { desc = 'Toggle LSP diagnostics' })
