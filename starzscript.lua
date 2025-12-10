task.spawn(function()
    pcall(function()
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local UserInputService = game:GetService("UserInputService")
        local HttpService = game:GetService("HttpService")
        local player = Players.LocalPlayer
        local pgui = player:WaitForChild("PlayerGui")

        local CORRECT_PASSWORD = "starz"
        local MAX_ATTEMPTS = 3
        local passwordAttempts = 0
        local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

        game.StarterGui:SetCore("SendNotification", {
            Title = "starz by wock",
            Text = "loaded successfully, join the dc for more stuff discord.gg/j78zS2USdu",
            Duration = 6
        })

        -- KEY TOGGLE BUTTON
        local ToggleScreen = Instance.new("ScreenGui")
        ToggleScreen.Name = "StarzToggle"
        ToggleScreen.ResetOnSpawn = false
        ToggleScreen.Parent = pgui

        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(0,60,0,60)
        ToggleButton.Position = UDim2.new(0,20,0.5,-30)
        ToggleButton.BackgroundColor3 = Color3.fromRGB(25,25,40)
        ToggleButton.Text = "🔑"
        ToggleButton.TextColor3 = Color3.fromRGB(255,220,100)
        ToggleButton.Font = Enum.Font.GothamBlack
        ToggleButton.TextSize = 28
        ToggleButton.AutoButtonColor = false
        ToggleButton.ZIndex = 999
        ToggleButton.Parent = ToggleScreen
        Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0,12)

        local grad = Instance.new("UIGradient", ToggleButton)
        grad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(120,40,200)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(200,80,255))
        }
        grad.Rotation = 45

        local stroke = Instance.new("UIStroke", ToggleButton)
        stroke.Thickness = 3
        stroke.Color = Color3.fromRGB(255,200,100)
        stroke.Transparency = 0.3

        -- PASSWORD GUI
        local PasswordScreen = Instance.new("ScreenGui")
        PasswordScreen.Name = "StarzKey"
        PasswordScreen.ResetOnSpawn = false
        PasswordScreen.Parent = pgui

        local PasswordFrame = Instance.new("Frame")
        PasswordFrame.Size = isMobile and UDim2.new(0,320,0,280) or UDim2.new(0,380,0,300)
        PasswordFrame.Position = UDim2.new(0.5, isMobile and -160 or -190, -1, 0)
        PasswordFrame.BackgroundColor3 = Color3.fromRGB(15,15,25)
        PasswordFrame.Parent = PasswordScreen
        Instance.new("UICorner", PasswordFrame).CornerRadius = UDim.new(0,16)

        local FrameGrad = Instance.new("UIGradient", PasswordFrame)
        FrameGrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(40,20,80)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(80,40,140))
        }

        local FrameStroke = Instance.new("UIStroke", PasswordFrame)
        FrameStroke.Thickness = 4
        FrameStroke.Color = Color3.fromRGB(200,100,255)
        FrameStroke.Transparency = 0.3

        local RedOverlay = Instance.new("Frame", PasswordFrame)
        RedOverlay.Size = UDim2.new(1,0,1,0)
        RedOverlay.BackgroundColor3 = Color3.fromRGB(255,60,60)
        RedOverlay.BackgroundTransparency = 1
        RedOverlay.ZIndex = 0

        local TitleBar = Instance.new("Frame", PasswordFrame)
        TitleBar.Size = UDim2.new(1,0,0,50)
        TitleBar.BackgroundColor3 = Color3.fromRGB(20,20,35)
        Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0,16)

        local Title = Instance.new("TextLabel", TitleBar)
        Title.Size = UDim2.new(1,-80,1,0)
        Title.Position = UDim2.new(0,20,0,0)
        Title.BackgroundTransparency = 1
        Title.Text = "starz key system"
        Title.TextColor3 = Color3.fromRGB(255,220,100)
        Title.Font = Enum.Font.GothamBlack
        Title.TextSize = 20
        Title.TextXAlignment = Enum.TextXAlignment.Left

        local CloseBtn = Instance.new("TextButton", TitleBar)
        CloseBtn.Size = UDim2.new(0,35,0,35)
        CloseBtn.Position = UDim2.new(1,-45,0.5,-17.5)
        CloseBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
        CloseBtn.Text = "×"
        CloseBtn.TextColor3 = Color3.new(1,1,1)
        CloseBtn.Font = Enum.Font.GothamBlack
        CloseBtn.TextSize = 28
        Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1,0)

        local InputBox = Instance.new("TextBox", PasswordFrame)
        InputBox.Size = UDim2.new(1,-40,0,50)
        InputBox.Position = UDim2.new(0,20,0,100)
        InputBox.BackgroundColor3 = Color3.fromRGB(25,25,40)
        InputBox.PlaceholderText = "Enter password..."
        InputBox.Text = ""
        InputBox.TextColor3 = Color3.new(1,1,1)
        InputBox.Font = Enum.Font.Gotham
        InputBox.TextSize = 22
        InputBox.ClearTextOnFocus = false
        Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0,10)

        local SubmitBtn = Instance.new("TextButton", PasswordFrame)
        SubmitBtn.Size = UDim2.new(1,-40,0,50)
        SubmitBtn.Position = UDim2.new(0,20,0,170)
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(120,40,200)
        SubmitBtn.Text = "SUBMIT"
        SubmitBtn.TextColor3 = Color3.new(1,1,1)
        SubmitBtn.Font = Enum.Font.GothamBlack
        SubmitBtn.TextSize = 20
        Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0,10)

        local StatusLabel = Instance.new("TextLabel", PasswordFrame)
        StatusLabel.Size = UDim2.new(1,-40,0,30)
        StatusLabel.Position = UDim2.new(0,20,1,-50)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "Attempts: 3/3"
        StatusLabel.TextColor3 = Color3.fromRGB(200,200,255)
        StatusLabel.Font = Enum.Font.Gotham
        StatusLabel.TextSize = 16

        -- WRONG PASSWORD EFFECT
        local function WrongPasswordEffect()
            RedOverlay.BackgroundTransparency = 0.55
            TweenService:Create(RedOverlay, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
            local orig = PasswordFrame.Position
            for i = 1,14 do
                local offset = (i % 2 == 0) and -14 or 14
                PasswordFrame:TweenPosition(orig + UDim2.new(0,offset,0,0), "Out", "Quad", 0.05, true)
                task.wait(0.05)
            end
            PasswordFrame:TweenPosition(orig, "Out", "Quad", 0.1, true)
        end

        -- CHECK PASSWORD
        local function CheckPassword()
            local input = InputBox.Text:lower():gsub("%s+","")
            if input == CORRECT_PASSWORD then
                TweenService:Create(PasswordFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5,-190,-1,0)}):Play()
                task.wait(0.6)
                PasswordScreen:Destroy()
                ToggleScreen:Destroy()
                LoadMainUI()
            else
                passwordAttempts += 1
                StatusLabel.Text = `Wrong password! Attempts left: {MAX_ATTEMPTS - passwordAttempts}`
                StatusLabel.TextColor3 = Color3.fromRGB(255,90,90)

                if passwordAttempts >= MAX_ATTEMPTS then
                    player:Kick("wrong key dumbass join the dc for the real one🤡 discord.gg/j78zS2USdu")
                else
                    WrongPasswordEffect()
                    InputBox.Text = ""
                    task.wait(0.35)
                    InputBox:CaptureFocus()
                end
            end
        end

        SubmitBtn.MouseButton1Click:Connect(CheckPassword)
        InputBox.FocusLost:Connect(function(enter) if enter then CheckPassword() end end)

        -- TOGGLE KEY GUI
        local keyOpen = false
        local function ToggleKeyGUI()
            keyOpen = not keyOpen
            if keyOpen then
                PasswordFrame:TweenPosition(UDim2.new(0.5, isMobile and -160 or -190, 0.5, isMobile and -140 or -150), "Out", "Back", 0.5, true)
                task.wait(0.4)
                InputBox:CaptureFocus()
            else
                PasswordFrame:TweenPosition(UDim2.new(0.5, isMobile and -160 or -190, -1, 0), "In", "Quad", 0.4, true)
            end
        end

        ToggleButton.MouseButton1Click:Connect(ToggleKeyGUI)
        CloseBtn.MouseButton1Click:Connect(ToggleKeyGUI)

        -- DRAGGABLE KEY BUTTON
        local draggingToggle = false
        local dragStartT, startPosT
        ToggleButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                draggingToggle = true
                dragStartT = input.Position
                startPosT = ToggleButton.Position
            end
        end)
        ToggleButton.InputChanged:Connect(function(input)
            if draggingToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStartT
                ToggleButton.Position = UDim2.new(startPosT.X.Scale, startPosT.X.Offset + delta.X, startPosT.Y.Scale, startPosT.Y.Offset + delta.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                draggingToggle = false
            end
        end)

        task.wait(0.8)
        ToggleKeyGUI()
    end)
end)

-- MAIN GUI - FULLY FUNCTIONAL
function LoadMainUI()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local HttpService = game:GetService("HttpService")
    local player = Players.LocalPlayer
    local pgui = player:WaitForChild("PlayerGui")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "StarzByWock"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = pgui

    -- STAR BUTTON
    local OpenButton = Instance.new("TextButton")
    OpenButton.Size = UDim2.new(0,70,0,70)
    OpenButton.Position = UDim2.new(0,15,0.5,-35)
    OpenButton.BackgroundTransparency = 1
    OpenButton.Text = ""
    OpenButton.ZIndex = 999
    OpenButton.Parent = ScreenGui

    local StarGrad = Instance.new("UIGradient", OpenButton)
    StarGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,240,100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255,180,0))
    }
    StarGrad.Rotation = 45
    Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(1,0)

    local StarStroke = Instance.new("UIStroke", OpenButton)
    StarStroke.Thickness = 5
    StarStroke.Color = Color3.fromRGB(255,220,80)
    StarStroke.Transparency = 0.2

    local StarLabel = Instance.new("TextLabel", OpenButton)
    StarLabel.Size = UDim2.new(1,0,1,0)
    StarLabel.BackgroundTransparency = 1
    StarLabel.Text = "Star"
    StarLabel.TextColor3 = Color3.new(0,0,0)
    StarLabel.Font = Enum.Font.GothamBlack
    StarLabel.TextSize = 44

    local pulse = TweenService:Create(StarStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.8})
    pulse:Play()

    -- MAIN FRAME
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0,460,0,380)
    MainFrame.Position = UDim2.new(0.5,-230,1.5,0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18,18,35)
    MainFrame.ClipsDescendants = true
    MainFrame.BackgroundTransparency = 1
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,16)

    local MainGrad = Instance.new("UIGradient", MainFrame)
    MainGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60,40,120)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40,25,100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15,15,40))
    }
    MainGrad.Rotation = 145

    local Glow = Instance.new("UIStroke", MainFrame)
    Glow.Thickness = 3
    Glow.Color = Color3.fromRGB(200,120,255)
    Glow.Transparency = 0.7

    -- TITLE BAR
    local TitleBar = Instance.new("Frame", MainFrame)
    TitleBar.Size = UDim2.new(1,0,0,50)
    TitleBar.BackgroundColor3 = Color3.fromRGB(18,18,35)
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0,16)

    local Title = Instance.new("TextLabel", TitleBar)
    Title.Size = UDim2.new(1,-100,1,0)
    Title.Position = UDim2.new(0,15,0,0)
    Title.BackgroundTransparency = 1
    Title.Text = "starz by wock"
    Title.TextColor3 = Color3.new(0,0,0)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 28
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", TitleBar)
    CloseBtn.Size = UDim2.new(0,40,0,40)
    CloseBtn.Position = UDim2.new(1,-50,0,5)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(220,50,50)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 36

    -- SIDEBAR
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0,130,1,-50)
    Sidebar.Position = UDim2.new(0,0,0,50)
    Sidebar.BackgroundTransparency = 0.3
    Sidebar.BackgroundColor3 = Color3.fromRGB(15,15,30)

    local SidebarList = Instance.new("UIListLayout", Sidebar)
    SidebarList.Padding = UDim.new(0,10)

    -- CONTENT
    local ContentScroll = Instance.new("ScrollingFrame", MainFrame)
    ContentScroll.Size = UDim2.new(1,-140,1,-60)
    ContentScroll.Position = UDim2.new(0,130,0,50)
    ContentScroll.BackgroundTransparency = 1
    ContentScroll.ScrollBarThickness = 6
    ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(200,140,255)
    ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local Padding = Instance.new("UIPadding", ContentScroll)
    Padding.PaddingTop = UDim.new(0,12)
    Padding.PaddingLeft = UDim.new(0,12)
    Padding.PaddingRight = UDim.new(0,12)
    Padding.PaddingBottom = UDim.new(0,12)

    local Layout = Instance.new("UIListLayout", ContentScroll)
    Layout.Padding = UDim.new(0,10)

    -- TAB SYSTEM
    local CurrentTab = nil
    local function CreateTab(name, emoji)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,-20,0,45)
        btn.BackgroundColor3 = Color3.fromRGB(30,30,60)
        btn.Text = "  " .. emoji .. "  " .. name
        btn.TextColor3 = Color3.fromRGB(220,220,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = Sidebar
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

        btn.MouseButton1Click:Connect(function()
            if CurrentTab == btn then return end
            if CurrentTab then CurrentTab.BackgroundColor3 = Color3.fromRGB(30,30,60) end
            btn.BackgroundColor3 = Color3.fromRGB(160,80,240)
            CurrentTab = btn
        end)
        return btn
    end

    local function AddButton(name, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,0,0,50)
        btn.BackgroundColor3 = Color3.fromRGB(35,35,70)
        btn.Text = "  " .. name
        btn.TextColor3 = Color3.fromRGB(230,230,255)
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 18
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.AutoButtonColor = false
        btn.Parent = ContentScroll
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)

        local grad = Instance.new("UIGradient", btn)
        grad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(90,60,140)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(50,40,100))
        }

        local stroke = Instance.new("UIStroke", btn)
        stroke.Thickness = 2
        stroke.Color = Color3.fromRGB(160,100,240)
        stroke.Transparency = 0.5

        btn.MouseButton1Click:Connect(callback)
    end

    local function ClearContent()
        for _,v in ContentScroll:GetChildren() do
            if v:IsA("GuiButton") or v:IsA("TextLabel") then v:Destroy() end
        end
    end

    -- TABS
    local HomeTab = CreateTab("Home", "🏠")
    local SabTab = CreateTab("Sab", "👻")
    local BSSTab = CreateTab("BSS", "🐝")
    local MiscTab = CreateTab("Misc", "⚙️")
    local ScriptsTab = CreateTab("Scripts", "📜")

    HomeTab.MouseButton1Click:Connect(function()
        ClearContent()
        local t = Instance.new("TextLabel")
        t.Size = UDim2.new(1,0,0,60)
        t.BackgroundTransparency = 1
        t.Text = "starz by wock"
        t.TextColor3 = Color3.fromRGB(200,140,255)
        t.Font = Enum.Font.GothamBlack
        t.TextSize = 40
        t.Parent = ContentScroll

        local d = Instance.new("TextLabel")
        d.Size = UDim2.new(1,0,0,140)
        d.BackgroundTransparency = 1
        d.Text = "made by wock join the dc for updates and shit discord.gg/j78zS2USdu"
        d.TextColor3 = Color3.fromRGB(200,200,255)
        d.Font = Enum.Font.Gotham
        d.TextSize = 20
        d.TextWrapped = true
        d.Parent = ContentScroll
    end)

    SabTab.MouseButton1Click:Connect(function()
        ClearContent()
        AddButton("Nameless Hub", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr"))() end)
        AddButton("Lemon Hub", function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/c4281c3937ebd537cb9e860182e41141.lua"))() end)
        AddButton("Chilli", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))() end)
        AddButton("Infinite Yield", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
    end)

    BSSTab.MouseButton1Click:Connect(function()
        ClearContent()
        AddButton("Macroware", function() loadstring(game:HttpGet("https://macroware.cc/loader.lua"))() end)
    end)

    local fpsBoosted = false
    local oldSettings = {}
    MiscTab.MouseButton1Click:Connect(function()
        ClearContent()
        AddButton("Rejoin", function() game:GetService("TeleportService"):Teleport(game.PlaceId, player) end)
        AddButton("Server Hop", function()
            local s = game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
            local l = HttpService:JSONDecode(s)
            for _,v in l.data do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id, player)
                    break
                end
            end
        end)
        AddButton("Copy Discord", function() setclipboard("https://discord.gg/j78zS2USdu")
            game.StarterGui:SetCore("SendNotification",{Title="Copied",Text="Join up!",Duration=3}) end)
        AddButton("FPS Boost", function()
            if fpsBoosted then return end
            fpsBoosted = true
            oldSettings.quality = settings().Rendering.QualityLevel
            for _,v in workspace:GetDescendants() do
                if v:IsA("BasePart") then
                    oldSettings[v] = {v.Material, v.Reflectance}
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    oldSettings[v] = v.Transparency
                    v.Transparency = 1
                end
            end
            settings().Rendering.QualityLevel = 1
        end)
        AddButton("Disable FPS Boost", function()
            if not fpsBoosted then return end
            fpsBoosted = false
            for obj, data in pairs(oldSettings) do
                if obj.Parent then
                    if obj:IsA("BasePart") then
                        obj.Material = data[1]
                        obj.Reflectance = data[2]
                    elseif obj:IsA("Decal") or obj:IsA("Texture") then
                        obj.Transparency = data
                    end
                end
            end
            settings().Rendering.QualityLevel = oldSettings.quality
            oldSettings = {}
        end)
    end)

    ScriptsTab.MouseButton1Click:Connect(function()
        ClearContent()
        AddButton("Prison Life", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/scripture2025/FlashHub/refs/heads/main/PrisonLife"))() end)
    end)

    -- DRAGGING MAIN GUI
    local dragging = false
    local dragInput, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    TitleBar.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    TitleBar.InputEnded:Connect(function() dragging = false end)

    -- DRAGGABLE STAR BUTTON
    local draggingStar = false
    local dragStartS, startPosS
    OpenButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingStar = true
            dragStartS = input.Position
            startPosS = OpenButton.Position
        end
    end)
    OpenButton.InputChanged:Connect(function(input)
        if draggingStar and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartS
            OpenButton.Position = UDim2.new(startPosS.X.Scale, startPosS.X.Offset + delta.X, startPosS.Y.Scale, startPosS.Y.Offset + delta.Y)
        end
    end)
    OpenButton.InputEnded:Connect(function() draggingStar = false end)

    -- TOGGLE ANIMATION
    local isOpen = false
    local function ToggleGUI()
        isOpen = not isOpen
        if isOpen then
            pulse:Pause()
            StarStroke.Transparency = 0.2
            TweenService:Create(OpenButton, TweenInfo.new(0.2), {Size = UDim2.new(0,80,0,80)}):Play()
            task.delay(0.15, function() TweenService:Create(OpenButton, TweenInfo.new(0.2), {Size = UDim2.new(0,70,0,70)}):Play() end)

            TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {
                Position = UDim2.new(0.5,-230,0.5,-190),
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(Glow, TweenInfo.new(0.7), {Transparency = 0.4}):Play()
            task.wait(0.5)
            HomeTab.MouseButton1Click:Fire()
        else
            pulse:Play()
            TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
                Position = UDim2.new(0.5,-230,1.5,0),
                BackgroundTransparency = 1
            }):Play()
            TweenService:Create(Glow, TweenInfo.new(0.5), {Transparency = 1}):Play()
        end
    end

    OpenButton.MouseButton1Click:Connect(ToggleGUI)
    CloseBtn.MouseButton1Click:Connect(ToggleGUI)

    task.wait(0.6)
    ToggleGUI()
end

-- AUTO OPEN MAIN GUI AFTER KEY (remove comment to test without key)
-- LoadMainUI()