local client = require "resty.websocket.client"
local time1 = os.clock()
local wb, err = client:new()
local uri = "ws://52.53.159.85/websocket"
local ok, err = wb:connect(uri)
local data = "hello"
if not ok then
    ngx.say("failed to connect: " .. err)
    return
end
------------------send text-----------------------
local bytes, err = wb:send_text("copy: " .. data)
if not bytes then
    ngx.say("failed to send frame: ", err)
    return
end
-----------------receive frame---------------------
local data, typ, err = wb:recv_frame()
if not data then
    ngx.say("failed to receive the frame: ", err)
    return
end

ngx.say("CONNECT+SEND+RECEIVE Costs: ", (os.clock()-time1)*1000, "ms")
ngx.say("received: ", data, " (", typ, ") error:", err)

-----------------send close------------------------
local bytes, err = wb:send_close()
if not bytes then
    ngx.say("failed to send frame: ", err)
    return
end

