--
-- Author: Deadline
-- Date: 2017-06-30 16:46:43
--
local skynet = require("skynet")
require "skynet.manager"
local db = {}
local command = {}

function command.get( key )
	print("command.get:"..key)
	return db[key]
end

function command.set( key,value )
	print("command.set:",key,value)
	db[key] = value
	return value
end

skynet.start(function ( ... )
	print("Start Service2")
	skynet.dispatch("lua",function ( session,address,cmd,... )
		print("Service2 dispatch",cmd)
		local f = command[cmd]
		if f then
			skynet.ret(skynet.pack(f(...)))
		else
			error(string.format("Unknown command %s",tostring(cmd)))
		end
	end)
	skynet.register "SERVICE2"
end)