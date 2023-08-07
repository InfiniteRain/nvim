---@diagnostic disable-next-line: deprecated
table.unpack = table.unpack or unpack

local function recursive_require(path)
	local root_path = vim.fn.stdpath("config") .. "/lua/" .. path

	for _, file in ipairs(vim.fn.readdir(root_path)) do
		local filepath = root_path .. "/" .. file
		local file_extension = file:sub(-4)

		if vim.fn.isdirectory(filepath) ~= 0 then
			recursive_require(path .. "/" .. file)
		elseif file_extension == ".lua" then
			local package_name = file:sub(0, -5)
			local require_dir_path = path:gsub("/+", "."):gsub("^%.+", ""):gsub("%.+$", "")
			local require_package_path = require_dir_path .. "." .. package_name

			require(require_package_path)
		end
	end
end

local function safe_require(...)
	local args = { ... }

	local to_require = {}
	local required_packages = {}
	local is_end = false
	local callback
	local error_callback

	for i = 1, #args do
		local arg = args[i]

		if type(arg) == "string" and not is_end then
			table.insert(to_require, arg)
		elseif type(arg) == "function" and not is_end then
			callback = arg
			is_end = true
		elseif type(arg) == "function" and is_end and error_callback == nil then
			error_callback = arg
		else
			error("Unexpected argument of type " .. type(args[i]) .. " passed as argument #" .. i)
		end
	end

	if #to_require == 0 then
		error("No arguments passed. Expected at least two, a package name (string) and a callback (function)")
	end

	if callback == nil then
		error("No callback passed. A callback should be passed after a list of package names")
	end

	for _, package in pairs(to_require) do
		local status, required_package = pcall(require, package)

		if not status then
			if error_callback ~= nil then
				error_callback(package)
			end

			return
		end

		table.insert(required_packages, required_package)
	end

	callback(table.unpack(required_packages))
end

local function safe_vim_cmd(cmd, error_callback)
	---@diagnostic disable-next-line: param-type-mismatch
	local status, _ = pcall(vim.cmd, cmd)
	if not status then
		error_callback()
	end
end

return {
	recursive_require = recursive_require,
	safe_require = safe_require,
	safe_vim_cmd = safe_vim_cmd,
}
