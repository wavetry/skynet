--
-- Author: Deadline
-- Date: 2017-06-30 17:54:51
--
package.cpath = "luaclib/?.so"
package.path = "lualib/?.lua;myexample/e1/.lua"

if _VERSION ~= "Lua 5.3" then
	error "Use lua 5.3"
end

local socket = require "client.socket"
local fd = assert(socket.connect("127.0.0.1", 8888))

socket.send(fd,"Hello world")
while true do
	local str = socket.recv(fd)
	if str ~= nil and str ~= "" then
		print("server say:===>",str)
	end

	local readstr = socket.readstdin()
	if readstr then
		if "quit" == readstr then
			socket.close()
			break
		else
			socket.send(fd,readstr)
		end
	else
		socket.usleep(100)
	end
end