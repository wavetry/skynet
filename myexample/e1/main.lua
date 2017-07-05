--
-- Author: Deadline
-- Date: 2017-06-30 16:27:31
--
local skynet = require "skynet"

skynet.start(function ( ... )
	print("Start Server")
	-- local service2 = skynet.newservice("service2")
	-- skynet.call(service2,"lua","set","key1","linzhilang")
	-- local value = skynet.call(service2,"lua","get","key1")
	-- print(value)

	-- skynet.newservice("socket1")


	-- skynet.newservice("socket2")
	skynet.newservice("socket3")
	

	skynet.exit()
end)