local unpack = table.unpack == nil and unpack or table.unpack

return {
	safe_require = function(...)
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

		callback(unpack(required_packages))
	end,
}
