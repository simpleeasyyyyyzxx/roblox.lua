local function get_service(name)
    local success, service = pcall(function()
        return game:GetService(name)
    end)
    return success and service or nil
end

local Players       = get_service("Players") or error("Players service not found")
local RunService    = get_service("RunService") or error("RunService not found")
local Workspace     = get_service("Workspace") or error("Workspace not found")
local Lighting      = get_service("Lighting") or error("Lighting not found")
local LocalPlayer   = Players.LocalPlayer or error("LocalPlayer not found")

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

task.spawn(function()
    while true do
        for i = 1, 50 do
            for _, model in ipairs(workspace:GetChildren()) do
                if model:IsA("Model") and model:FindFirstChildOfClass("Humanoid") then
                    for _, item in ipairs(model:GetChildren()) do
                        if item:IsA("Accessory") or item:IsA("Hat") or item:IsA("CharacterMesh")
                        or item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic")
                        or item:IsA("Face") then
                            pcall(function()
                                item:Destroy()
                            end)
                        end
                    end
                end
            end
        end
        task.wait(0.05)
    end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "SHAKE_AND_BAKE_MENU"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 340)
frame.Position = UDim2.new(0.5, -140, 0.5, -170)
frame.BackgroundColor3 = Color3.fromRGB(220, 240, 255)  -- soft pastel cyan base
frame.BackgroundTransparency = 0.5   -- semi-translucent jelly
frame.Active = true
frame.Draggable = true
frame.Visible = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 28)
corner.Parent = frame

local outerStroke = Instance.new("UIStroke")
outerStroke.Color = Color3.fromRGB(255, 255, 255)
outerStroke.Transparency = 0.5
outerStroke.Thickness = 4
outerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
outerStroke.Parent = frame

local innerGlow = Instance.new("Frame")
innerGlow.Size = UDim2.new(1, -20, 1, -20)
innerGlow.Position = UDim2.new(0, 10, 0, 10)
innerGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
innerGlow.BackgroundTransparency = 0.85
innerGlow.Parent = frame
local innerCorner = Instance.new("UICorner")
innerCorner.CornerRadius = UDim.new(0, 24)
innerCorner.Parent = innerGlow

local innerGradient = Instance.new("UIGradient")
innerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 220, 255))
}
innerGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.4),
    NumberSequenceKeypoint.new(1, 1)
}
innerGradient.Rotation = 135
innerGradient.Parent = innerGlow

-- Subtle shadow frame (for depth)
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
shadow.BackgroundTransparency = 0.7
shadow.ZIndex = -1
shadow.Parent = frame
local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 30)
shadowCorner.Parent = shadow

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 0, 60)  -- reduced width so it doesn't overlap close button
title.Position = UDim2.new(0.15, 0, 0, 0)  -- centered horizontally
title.BackgroundTransparency = 1
title.Text = "SHAKE AND BAKE"
title.Font = Enum.Font.Bangers
title.TextSize = 36
title.TextStrokeTransparency = 0.7
title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
title.TextYAlignment = Enum.TextYAlignment.Center
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

task.spawn(function()
    local hue = 0.5
    while true do
        hue = (hue + 0.001) % 1
        title.TextColor3 = Color3.fromHSV(hue, 0.6, 1)
        title.TextStrokeColor3 = Color3.fromHSV((hue + 0.15) % 1, 0.5, 0.9)
        task.wait(0.03)
    end
end)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 44, 0, 44)
closeBtn.Position = UDim2.new(1, -54, 0, 12)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 190, 210)  -- soft pink accent
closeBtn.BackgroundTransparency = 0.35
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.Font = Enum.Font.Bangers
closeBtn.TextSize = 30
closeBtn.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 14)
closeCorner.Parent = closeBtn

local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.fromRGB(255, 255, 255)
closeStroke.Transparency = 0.45
closeStroke.Thickness = 2.5
closeStroke.Parent = closeBtn

local reopenGui = Instance.new("ScreenGui")
reopenGui.Name = "FPS_Reopen"
reopenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.new(0, 90, 0, 45)
reopenBtn.Position = UDim2.new(0, 15, 0.5, -22)
reopenBtn.BackgroundColor3 = Color3.fromRGB(220, 240, 255)
reopenBtn.BackgroundTransparency = 0.4
reopenBtn.TextColor3 = Color3.fromRGB(255,80,80)
reopenBtn.Text = "Open"
reopenBtn.Font = Enum.Font.Bangers
reopenBtn.TextSize = 20
reopenBtn.Visible = false
reopenBtn.Parent = reopenGui

local reopenCorner = Instance.new("UICorner")
reopenCorner.CornerRadius = UDim.new(0, 14)
reopenCorner.Parent = reopenBtn

local reopenStroke = Instance.new("UIStroke")
reopenStroke.Color = Color3.fromRGB(255, 255, 255)
reopenStroke.Transparency = 0.45
reopenStroke.Thickness = 2.5
reopenStroke.Parent = reopenBtn

closeBtn.MouseButton1Click:Connect(function()
    gui.Enabled = false
    reopenBtn.Visible = true
end)

reopenBtn.MouseButton1Click:Connect(function()
    gui.Enabled = true
    reopenBtn.Visible = false
end)

local function createToggle(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -30, 0, 55)
    btn.Position = UDim2.new(0, 15, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(240, 250, 255)  -- very soft pastel
    btn.BackgroundTransparency = 0.4
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 80, 80)
    btn.Font = Enum.Font.Bangers
    btn.TextSize = 24
    btn.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 18)
    btnCorner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(255, 255, 255)
    btnStroke.Transparency = 0.45
    btnStroke.Thickness = 2.5
    btnStroke.Parent = btn

    -- Inner glow for layered depth
    local btnInner = Instance.new("Frame")
    btnInner.Size = UDim2.new(1, -10, 1, -10)
    btnInner.Position = UDim2.new(0, 5, 0, 5)
    btnInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btnInner.BackgroundTransparency = 0.7
    btnInner.ZIndex = 2
    btnInner.Parent = btn
    local btnInnerCorner = Instance.new("UICorner")
    btnInnerCorner.CornerRadius = UDim.new(0, 16)
    btnInnerCorner.Parent = btnInner

    local btnGradient = Instance.new("UIGradient")
    btnGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(220,240,255))
    }
    btnGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.35),
        NumberSequenceKeypoint.new(1, 1)
    }
    btnGradient.Rotation = -135
    btnGradient.Parent = btnInner

    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)

    return btn
end

local speedActive = false
local espActive = false

createToggle("SPEED BOOST: OFF", 145, function(btn)
    speedActive = not speedActive
    btn.Text = "SPEED BOOST: " .. (speedActive and "ON" or "OFF")
end)

createToggle("ESP: OFF", 210, function(btn)
    espActive = not espActive
    btn.Text = "ESP: " .. (espActive and "ON" or "OFF")
end)

task.spawn(function()
    while true do
        task.wait(0.005)
        if not speedActive then continue end

        local char = LocalPlayer.Character
        if not char then continue end

        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not humanoid or not root then continue end

        local direction = humanoid.MoveDirection
        if direction.Magnitude > 0 then
            root.AssemblyLinearVelocity = direction * 29.8
        end
    end
end)

local function createESP(player)
    if player == LocalPlayer or not player.Character then return end
    local char = player.Character

    if not char:FindFirstChild("ESP_Highlight") then
        local hl = Instance.new("Highlight")
        hl.Name = "ESP_Highlight"
        hl.Adornee = char
        hl.FillTransparency = 0.7
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.FillColor = Color3.fromRGB(255, 0, 0)
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.Parent = char
    end

    if not char:FindFirstChild("ESP_NameTag") then
        local bb = Instance.new("BillboardGui")
        bb.Name = "ESP_NameTag"
        bb.Adornee = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
        bb.Size = UDim2.new(0, 200, 0, 40)
        bb.StudsOffset = Vector3.new(0, 3.5, 0)
        bb.AlwaysOnTop = true
        bb.Parent = char

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = player.Name
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextStrokeTransparency = 0.5
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 18
        label.TextScaled = false
        label.Parent = bb

        task.spawn(function()
            local hue = 0
            while char and char.Parent do
                hue = (hue + 0.01) % 1
                label.TextColor3 = Color3.fromHSV(hue, 1, 1)
                task.wait(0.05)
            end
        end)
    end
end

RunService.RenderStepped:Connect(function()
    if not espActive then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local hl = plr.Character:FindFirstChild("ESP_Highlight")
                if hl then hl:Destroy() end
                local tag = plr.Character:FindFirstChild("ESP_NameTag")
                if tag then tag:Destroy() end
            end
        end
        return
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            createESP(plr)
        end
    end
end)

print("SHAKE AND BAKE FPS v1 LOADED, ESP AND SPEED ONLY SWITCH TO V2-V3 FOR ALL PERKS")
print("Speed Boost set to 29.5")
print("speed and esp only, allow and disallow friends coming soon")
print("go scam")
