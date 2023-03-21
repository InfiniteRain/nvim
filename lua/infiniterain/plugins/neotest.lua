local neotest_setup, neotest = pcall(require, "neotest")
if not neotest_setup then
	return
end

local neotest_jest_setup, neotest_jest = pcall(require, "neotest-jest")
if not neotest_jest_setup then
	return
end

neotest.setup({
	adapters = {
		neotest_jest({}),
	},
})