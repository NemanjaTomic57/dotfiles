local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jk", "<esc>", { desc = 'exit insert mode'})

vim.keymap.set("v", "j", ":m '>+1<cr>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "k", ":m '<-2<cr>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "j", "mzj`z")
vim.keymap.set("n", "<c-d>", "<c-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "n", "nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- clipboard things
vim.keymap.set("x", "<leader>p", [["_dp]], { desc = "paste without replacing clipboard content" })

vim.keymap.set("v", "p", '"_dp', opts)

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<c-c>", "<esc>")
vim.keymap.set("n", "<c-c>", ":nohl<cr>", { desc = "clear search hl", silent = true })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "q", "<nop>")
vim.keymap.set("n", "x", '"_x', opts)

vim.keymap.set("n", "<leader>s", [[:%s/\<<c-r><c-w>\>/<c-r><c-w>/gi<left><left><left>]], { desc = "replace word cursor is on globally" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<cr>", { silent = true, desc = "makes file executable" })

-- highlight yank
vim.api.nvim_create_autocmd("textyankpost", {
    desc = "highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<cr>")    -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>")  -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<cr>")      -- go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<cr>")      -- go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<cr>")  -- open current tab in new tab

-- split
vim.keymap.set("n", "<leader>sv", "<c-w>v", { desc = "split window vertically" })
vim.keymap.set("n", "<leader>sh", "<c-w>s", { desc = "split window horizontally" })
vim.keymap.set("n", "<leader>se", "<c-w>=", { desc = "make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "close current split" })

vim.keymap.set('n', '<c-h>', '<c-w>h', { desc = 'move to left split window'})
vim.keymap.set('n', '<c-j>', '<c-w>j', { desc = 'move to bottom split window'})
vim.keymap.set('n', '<c-k>', '<c-w>k', { desc = 'move to top split window'})
vim.keymap.set('n', '<c-l>', '<c-w>l', { desc = 'move to right split window'})

-- copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
    -- get the file path relative to the home directory
    local filepath = vim.fn.expand("%:~")
    -- copy the file path to the clipboard register
    vim.fn.setreg("+", filepath)
    print("file path copied to clipboard: " .. filepath)
end, { desc = "copy file path to clipboard" })
