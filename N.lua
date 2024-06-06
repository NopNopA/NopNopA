repeat task.wait(5) until game:IsLoaded()

loadstring(game:HttpGet'https://raw.githubusercontent.com/NopNopA/NopNopA/main/Close.txt')()

local RAMAccount = loadstring(game:HttpGet'https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/RAMAccount.lua')()
local MyAccount 
repeat task.wait() 
    MyAccount = RAMAccount.new(game:GetService'Players'.LocalPlayer.Name)
until MyAccount

if MyAccount then
    while true do 
        local err_msg, ok = pcall(function() 
            local err_ge, gems = pcall(function()
                return game:GetService("Players").LocalPlayer.PlayerGui.HUD.Toolbar.CurrencyList.Gems.TextLabel.Text
            end)
            local err_g, gold = pcall(function()
                return game:GetService("Players").LocalPlayer.PlayerGui.HUD.Toolbar.CurrencyList.Gold.TextLabel.Text
            end)
            local err_l, level = pcall(function()
                return game:GetService("Players").LocalPlayer.leaderstats["\240\159\148\165 Level"].Value
            end)
            print(gold, level, gems)
            if gems and gold and level then 
                MyAccount:SetAlias(string.format("[Gems: %s | Gold: %s | Level: %s]", gems, gold, level))
            end
            local Map 
            local IntroGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MatchIntroGui")
            if IntroGui then
                Map = game:GetService("Players").LocalPlayer.PlayerGui.MatchIntroGui.Holder.Chapter.TextLabel.Text
            else 
                Map = "In Lobby"
            end
            MyAccount:SetDescription(Map)
        end)
        task.wait(5)
    end
end
