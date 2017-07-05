--
-- Author: Deadline
-- Date: 2017-07-03 10:07:21
--
package.path = "lualib/?.lua;myexample/e1/?.lua"

local skynet = require "skynet"
require "skynet.manager"
local socket = require "skynet.socket"
local proto = require "proto"
local sproto = require "sproto"
local host
local REQUEST = {}
function REQUEST:say( ... )
	print("say",self.name,self.msg)
end

function REQUEST:handshake( ... )
	print("handshake")
end

function REQUEST:quit( ... )
	print("quit")
end

local function request( name,args,response )
	local f = assert(REQUEST[name])
	local r = f(args)
	if response then
		return response(r)
	end
end

local function send_package( fd,pack )
	local package = string.pack(">s2",pack)
	socket.write(fd,package)
end

local function accept( id )
	socket.start(id)
	host = sproto.new(proto.c2s):host "package"

	while true do
		local str = socket.read(id)
		if str then
			local type,str2,str3,str4 = host:dispatch(str)
			if type == "REQUEST" then
				local ok,result = pcall(request,str2,str3,str4)
				if ok then
					if result then
						socket.write(id,"收到了")
						-- print("response:"..result)
                        -- send_package(id,result)
					end
				else
					skynet.error(result)
				end
			end

			if type == "RESPONSE" then
				print("client response")
			end
		else
			socket.close(id)
			return 
		end
	end
end

skynet.start(function ( ... )
	print ("Start Socket3")
	local id = socket.listen("127.0.0.1",8888)
	print ("Listen socket:","127.0.0.1",8888)

	socket.start(id,function ( id,addr )
		print("connect from ",addr,id)
		accept(id)
	end)

end)