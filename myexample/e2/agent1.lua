--
-- Author: Deadline
-- Date: 2017-07-03 18:15:35
--
local skynet = require("skynet")
local socket  = require("client.socket")
local fd = ...
fd = tonumber(fd)

local function echo( id )
	socket.start(id)
	while true do
		local str = socket.read(id)
		if str then
			print("client say:",str)
			--socket.write(id,str)
		else
			socket.close(id)
			return 
		end
	end
end

skynet.start(function ( ... )
	skynet.fork(function ( ... )
		echo(fd)
		skynet.exit()
	end)
end)