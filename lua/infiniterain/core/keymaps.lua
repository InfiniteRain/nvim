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

-- prevent "x" from yanking
keymap.set("n", "x", '"_x')

-- prevent "c" from yanking
keymap.set("n", "c", '"_c')

-- prevent "p" from yanking
keymap.set("x", "p", "P")

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
keymap.set("n", "<leader>e", ":Neotree reveal toggle<cr>")

-- lazygit
keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>")

-- harpoon
keymap.set("n", "<leader>hh", ':lua require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())<cr>')
keymap.set("n", "<leader>ha", ':lua require("harpoon"):list():append()<cr>')
keymap.set("n", "<leader>hd", ':lua require("harpoon"):list():remove()<cr>')
for i = 1, 9 do
	keymap.set("n", "<leader>" .. i, ':lua require("harpoon"):list():select(' .. i .. ")<cr>")
end

-- monorepo
keymap.set("n", "<leader>mm", ':lua require("telescope").extensions.monorepo.monorepo()<cr>')
keymap.set("n", "<leader>mt", ':lua require("monorepo").toggle_project()<cr>')
for i = 1, 9 do
	keymap.set("n", "<leader>m" .. i, ':lua require("monorepo").go_to_project(' .. i .. ")<cr>")
end
