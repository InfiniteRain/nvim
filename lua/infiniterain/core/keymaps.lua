local keymap = vim.keymap

---
-- General keymaps
---

-- leader key
vim.g.mapleader = " "

-- clear search results
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- save file
keymap.set("n", "<leader>w", ":w<CR>")

-- clear single character
keymap.set("n", "x", '"_x')

-- increment number
keymap.set("n", "<leader>+", "<C-a>")

-- decrement number
keymap.set("n", "<leader>-", "<C-x>")

-- split vertically
keymap.set("n", "<leader>sv", "<C-w>v")

-- split horizontally
keymap.set("n", "<leader>sh", "<C-w>s")

-- equalize split windows
keymap.set("n", "<leader>se", "<C-w>=")

-- close current split window
keymap.set("n", "<leader>sx", ":close<CR>")

-- remap ctrl+u & ctrl+d to also recenter the viewport
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

---
-- Plugin keymaps
---

-- maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- neo-tree
keymap.set("n", "<leader>e", ":Neotree toggle<cr>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>")

-- lazygit
keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>")

-- harpoon
keymap.set("n", "<leader>hh", ':lua require("harpoon.ui").toggle_quick_menu()<cr>')
keymap.set("n", "<leader>ha", ':lua require("harpoon.mark").add_file()<cr>')
keymap.set("n", "<leader>hd", ':lua require("harpoon.mark").rm_file()<cr>')
for i = 1, 9 do
	keymap.set("n", "<leader>" .. i, ':lua require("harpoon.ui").nav_file(' .. i .. ")<cr>")
end
