repeat task.wait(10) until game:IsLoaded()
game:GetService("RunService"):Set3dRenderingEnabled(true)

local function makeScreenWhiteWithTextAndLogo()
    game:GetService("RunService"):Set3dRenderingEnabled(true)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WhiteScreen"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    
    local whiteFrame = Instance.new("Frame")
    whiteFrame.Size = UDim2.new(1, 0, 1, 0)
    whiteFrame.BackgroundColor3 = Color3.new(248,250,253) 
    whiteFrame.BorderSizePixel = 0
    whiteFrame.Parent = screenGui
    
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(0, 128, 0, 128) 
    imageLabel.Position = UDim2.new(0.5, -64, 0.2, 0) 
    imageLabel.Image = "rbxassetid://16761507262" 
    imageLabel.BackgroundTransparency = 1 
    imageLabel.Parent = screenGui
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0, 0, 0, 0) 
    textLabel.Position = UDim2.new(0.5, 0, 0.4, 0) 
    textLabel.Text = "NopNop Services"
    textLabel.TextColor3 = Color3.fromRGB(131,235,250) 
    textLabel.TextSize = 24
    textLabel.BackgroundTransparency = 1 
    textLabel.Parent = screenGui
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

game:GetService("RunService"):Set3dRenderingEnabled(true)
makeScreenWhiteWithTextAndLogo()

while true do
    if game:GetService("RunService"):Get3dRenderingEnabled() == false then
        game:GetService("RunService"):Set3dRenderingEnabled(true)
    end
    wait(1) 
end
