local neotest_setup, neotest = pcall(require, "neotest")
if not neotest_setup then
	return
end

local neotest_jest_setup, neotest_jest = pcall(require, "neotest-jest")
if not neotest_jest_setup then
	return
end

function is_jest_config(filename)
	local check_table = {
		["jest.config.js"] = true,
		["jest.config.ts"] = true,
		["jest.config.mjs"] = true,
		["jest.config.cjs"] = true,
		["jest.config.json"] = true,
	}

	return check_table[filename] or false
end

function strip_last_segment(path)
	local new_path = path:gsub("(.*)/.*$", "%1")

	if path == new_path then
		return false
	end

	return true, new_path
end

function find_jest_config_directory(path)
	local success, new_path = true, path
	repeat
		success, new_path = strip_last_segment(new_path)

		local paths = vim.split(vim.fn.glob(new_path .. "/*"), "\n")

		for _, file in pairs(paths) do
			local filename = file:sub(string.find(file, "/[^/]*$") + 1)

			if is_jest_config(filename) then
				return true, new_path
			end
		end
	until not success

	return false
end

local map_opts = { noremap = true, silent = true, nowait = true }

vim.keymap.set("n", "<leader>tf", function()
	vim.cmd("wall")
	neotest.run.run(vim.fn.expand("%"))
	neotest.summary.open()
end, map_opts)

vim.keymap.set("n", "<leader>tr", function()
	vim.cmd("wall")
	neotest.run.run()
end, map_opts)

vim.keymap.set("n", "<leader>ts", function()
	vim.cmd("wall")
	neotest.summary.toggle()
end, map_opts)

vim.keymap.set("n", "<leader>to", function()
	vim.cmd("wall")
	neotest.output.open({ enter = true })
end, map_opts)

neotest.setup({
	adapters = {
		neotest_jest({
			cwd = function(path)
				local is_success, directory = find_jest_config_directory(path)

				if is_success then
					return directory
				end

				return vim.fn.getcwd()
			end,
		}),
	},
	quickfix = {
		open = false,
		enabled = false,
	},
})
