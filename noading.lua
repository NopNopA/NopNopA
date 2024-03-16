repeat task.wait() until game:IsLoaded()

local Realname = game.Players.LocalPlayer.Name
local http = game:GetService("HttpService")
game.StarterGui:SetCore("SendNotification",{Title = 'Noading',Text='Noading Starting',Duration=60})
while true do
    local Json = {
        ['name'] = Realname,
        ['status'] = "online"
    }

    local Data = http:JSONEncode(Json)
    local server = http_request({
        Url = 'http://127.0.0.1:7909/index',
        Body = Data,
        Method = 'POST',
        Headers = {
            ["content-type"] = "application/json"
        }
    })

    print(server.StatusCode)
    wait(4)  
end
