--
-- Author: Deadline
-- Date: 2017-06-30 17:04:12
--
package.cpath = "luaclib/?.so"
package.path = "lualib/?.lua;myexample/e1/.lua"

if _VERSION ~= "Lua 5.3" then
	error "Use lua 5.3"
end

local socket = require "client.socket"
local fd = assert(socket.connect("127.0.0.1", 8888))

socket.send(fd,"Hello world")