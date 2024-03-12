task.spawn(function()
    repeat task.wait(10) until game:IsLoaded()
    local Socket = syn and syn.websocket.connect or (Krnl and (function() repeat task.wait() until Krnl.WebSocket and Krnl.WebSocket.connect return Krnl.WebSocket.connect end)()) or  WebSocket and WebSocket.connect
    local globalEnv = (function() 
        if typeof(getgenv) == "function" and typeof(getgenv()) == "table" then return getgenv() end 
        if typeof(_G) == "table" then return _G end 
        return {}
    end)()
    local HttpService = game:GetService("HttpService")
    if not Socket then return false end 
    if typeof(globalEnv["__NopNopSocket__"]) == "table" then return wanr("Socket is already connected") end
    if typeof(globalEnv["__Nop__Socket__Config"]) == "nil" then 
        globalEnv.__Nop__Socket__Config = {
            ["host"] = "localhost",
            ["port"] = 7909,
            ["path"] = "/"
        }
    end
    local config = globalEnv["__Nop__Socket__Config"]
    local err, Socket = pcall(Socket, string.format("ws://%s:%d%s", config["host"], config["port"], config["path"]))

    if not err then task.wait(5) end 

    globalEnv["__NopNopSocket__"] = Socket
    Socket.OnMessage:Connect(function()
        print("Got mesage")
    end)

    Socket.OnClose:Connect(function() 
        print("Websocket is closing..")
        game.StarterGui:SetCore("SendNotification",{Title = 'Websocket is closing..',Text='Please Restart',Duration=5})
        globalEnv["__NopNopSocket__"] = nil
    end)

    while true do
        local username = game.Players.LocalPlayer.Name
        local data_send = username .. ",🟢 Online"
        Socket:Send(HttpService:JSONEncode(data_send))
        task.wait(2.5)
    end    
end)
