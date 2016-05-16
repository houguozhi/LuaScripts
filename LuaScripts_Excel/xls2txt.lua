-- print "\n\n------------------\nHello, world\n"
print (lua_file_full_path)
local path = lua_file_full_path:sub(1, -lua_file_full_path:reverse():find("\\"))
print (path)

ft = {
 [[D:\Users\hgz\work\Lua\LuaScripts\LuaScripts_Excel\D94364.xlsx]],
-- [[D:\Users\hgz\work\Lua\LuaScripts\LuaScripts_Excel\HS6206(A2)-D7U317(13#14#).xls]],
-- [[D:\Users\hgz\work\Lua\LuaScripts\LuaScripts_Excel\HS6206(A2)-D7U317(13#14#)的测试数据.xls]],
}

excel.DoConvert(ft[1])

