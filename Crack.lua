repeat 
    task.wait(10) 
until game:IsLoaded()


local function makeScreenWhite()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WhiteScreen"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    
    local whiteFrame = Instance.new("Frame")
    whiteFrame.Size = UDim2.new(1, 0, 1, 0)
    whiteFrame.BackgroundColor3 = Color3.new(248,250,253) 
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
local decalsyeeted = true
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
sethiddenproperty(l,"Technology",2)
sethiddenproperty(t,"Decoration",false)
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = 0
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i, v in pairs(w:GetDescendants()) do
    if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("MeshPart") and decalsyeeted then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    elseif v:IsA("SpecialMesh") and decalsyeeted  then
        v.TextureId=0
    elseif v:IsA("ShirtGraphic") and decalsyeeted then
        v.Graphic=1
    elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
        v[v.ClassName.."Template"]=1
    end
end
for i = 1,#l:GetChildren() do
    e=l:GetChildren()[i]
    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
        e.Enabled = false
    end
end
w.DescendantAdded:Connect(function(v)
   if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("MeshPart") and decalsyeeted then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    elseif v:IsA("SpecialMesh") and decalsyeeted then
        v.TextureId=0
    elseif v:IsA("ShirtGraphic") and decalsyeeted then
        v.ShirtGraphic=1
    elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
        v[v.ClassName.."Template"]=1
            end
        end)

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
local Fps_low = 2
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
    wait(20)  
end
