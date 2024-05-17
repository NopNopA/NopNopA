repeat task.wait(10) until game:IsLoaded()


local function makeScreenWhite()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WhiteScreen"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    
    local whiteFrame = Instance.new("Frame")
    whiteFrame.Size = UDim2.new(1, 0, 1, 0)
    whiteFrame.BackgroundColor3 = Color3.new(129/255, 255/255, 222/255) 
    whiteFrame.BorderSizePixel = 0
    whiteFrame.Parent = screenGui
    
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local function toggleWhiteScreen()
        screenGui.Enabled = not screenGui.Enabled
    end
    
    local inputService = game:GetService("UserInputService")
    inputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.L then 
            toggleWhiteScreen()
        end
    end)
end


UserSettings():GetService("UserGameSettings").MasterVolume = 0
makeScreenWhite() 
game:GetService("RunService"):Set3dRenderingEnabled(true)

local function getGlobal(path)
	local value = getfenv(0)

	while value ~= nil and path ~= "" do
		local name, nextValue = string.match(path, "^([^.]+)%.?(.*)$")
		value = value[name]
		path = nextValue
	end

	return value
end

local function test(name, aliases, callback)

	task.spawn(function()
		if not callback then
			print("\n")
		elseif not getGlobal(name) then
			print("\n")
		else
			local success, message = pcall(callback)
	
			if success then
				print("\n")
			else
				print("\n")
			end
		end
	
		local undefinedAliases = {}
	
		for _, alias in ipairs(aliases) do
			if getGlobal(alias) == nil then
				table.insert(undefinedAliases, alias)
			end
		end
	
		if #undefinedAliases > 0 then
			print("\n")
		end

		print("\n")
	end)
end

test("request", {"http.request", "http_request"}, function()
	local response = request({
		Url = "https://httpbin.org/user-agent",
		Method = "GET",
	})
	assert(type(response) == "table", "Response must be a table")
	assert(response.StatusCode == 200, "Did not return a 200 status code")
	local data = game:GetService("HttpService"):JSONDecode(response.Body)
	assert(type(data) == "table" and type(data["user-agent"]) == "string", "Did not return a table with a user-agent key")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Executor!",
        Text = data["user-agent"],
        Duration = 5
    })
    print(data["user-agent"])
end)

local renderStepped = game:GetService("RunService").RenderStepped
local Fps_low = 3
local function step()
    renderStepped:Wait()
    local sum = 0
    for _ = 1, 5 do
        sum = sum + 1 / renderStepped:Wait()
    end
    print("⏺️ Fps:" .. math.round(sum / 5))
    return math.round(sum / 5)
end

while true do
    local Fps = step()
    if Fps_low >= Fps then
        print("⚠️ Low Local FPS")
        wait(35)
        local Fps_1 = step()
        if Fps_low >= Fps_1 then
            warn("⚠️ Restarting Game")
            game.Players.LocalPlayer:Kick('[⛔] Restarting due to low FPS')
        end
    end
end
