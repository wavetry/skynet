--
-- Author: Deadline
-- Date: 2017-07-03 18:09:41
--
local skynet = require "skynet"
require "skynet.manager"
local socket = require "socket"

local function accept1( id )
	socket.start(id)
	socket.write(id,"Hello Skynet\n")
	skynet.newservice("agent1",id)
	socket.abandon(id)
end

local function accept2( id )
	socket.start(id)
	local agent2 = skynet.newservice("agent2")
	skynet.call(agent2,"lua",id)
	skynet.abandon(id)
end

skynet.start(function ( ... )
	local id = socket.listen("127.0.0.1",8888)
	print("Listen socket:","127.0.0.1",8888)
	socket.start(id,function ( id,addr )
		print("connect from",addr,id)
		accept2(id)
	end)
	skynet.register "SOCKET1"
end)

