local cmake_tools_ok, cmake_tools = pcall(require, "cmake-tools")

if not cmake_tools_ok then
	return
end

cmake_tools.setup({})
