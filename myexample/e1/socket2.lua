--
-- Author: Deadline
-- Date: 2017-06-30 17:49:56
--
local skynet = require "skynet"
local socket = require "skynet.socket"

local function echo( id )
	socket.start(id)

	while true do
		local str = socket.read(id)
		if str then
			print("client say:===>",str)
			socket.write(id,str)
		else
			socket.close(id)
			return
		end
	end
end

skynet.start(function ( ... )
	print("Start Socket2")
	local id = socket.listen("127.0.0.1",8888)
	print("Listen socket:","127.0.0.1",8888)

	socket.start(id,function ( id,addr )
		print("connect from",addr,id)
		echo(id)
	end)
end)