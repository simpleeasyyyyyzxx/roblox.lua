task.spawn(function()
    pcall(function()
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local UserInputService = game:GetService("UserInputService")
        local HttpService = game:GetService("HttpService")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer
        local pgui = player:WaitForChild("PlayerGui")
        
        -- PASSWORD CONFIGURATION
        local CORRECT_PASSWORD = "starz"  -- Change this to your desired password
        local MAX_ATTEMPTS = 3
        
        -- Mobile detection
        local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
        local passwordAttempts = 0
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "starz by wock";
            Text = "loaded successfully join up bitch, discord.gg/j78zS2USdu";
            Duration = 6;
        })

        -- Create toggle button FIRST (so it appears first)
        local ToggleScreen = Instance.new("ScreenGui")
        ToggleScreen.Name = "ToggleScreen"
        ToggleScreen.ResetOnSpawn = false
        ToggleScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ToggleScreen.Parent = pgui

        -- Modern Toggle Button
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Name = "PasswordToggle"
        ToggleButton.Size = UDim2.new(0, 60, 0, 60)
        ToggleButton.Position = UDim2.new(0, 20, 0.5, -30) -- Left side, centered vertically
        ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
        ToggleButton.Text = "🔑"
        ToggleButton.TextColor3 = Color3.fromRGB(255, 220, 100)
        ToggleButton.Font = Enum.Font.GothamBlack
        ToggleButton.TextSize = 28
        ToggleButton.AutoButtonColor = false
        ToggleButton.ZIndex = 999
        ToggleButton.Parent = ToggleScreen
        
        -- Modern styling for toggle button
        local ToggleCorner = Instance.new("UICorner", ToggleButton)
        ToggleCorner.CornerRadius = UDim.new(0, 12)
        
        local ToggleGradient = Instance.new("UIGradient", ToggleButton)
        ToggleGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(100, 40, 160)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 80, 220)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(100, 40, 160))
        }
        ToggleGradient.Rotation = 45
        
        local ToggleStroke = Instance.new("UIStroke", ToggleButton)
        ToggleStroke.Thickness = 3
        ToggleStroke.Color = Color3.fromRGB(255, 200, 100)
        ToggleStroke.Transparency = 0.3
        
        local ToggleShadow = Instance.new("ImageLabel", ToggleButton)
        ToggleShadow.Name = "Shadow"
        ToggleShadow.Size = UDim2.new(1, 10, 1, 10)
        ToggleShadow.Position = UDim2.new(0, -5, 0, -5)
        ToggleShadow.BackgroundTransparency = 1
        ToggleShadow.Image = "rbxassetid://1316045217"
        ToggleShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        ToggleShadow.ImageTransparency = 0.8
        ToggleShadow.ScaleType = Enum.ScaleType.Slice
        ToggleShadow.SliceCenter = Rect.new(10, 10, 118, 118)
        ToggleShadow.ZIndex = -1
        
        -- Glow effect
        local ToggleGlow = Instance.new("ImageLabel", ToggleButton)
        ToggleGlow.Name = "Glow"
        ToggleGlow.Size = UDim2.new(1, 20, 1, 20)
        ToggleGlow.Position = UDim2.new(0, -10, 0, -10)
        ToggleGlow.BackgroundTransparency = 1
        ToggleGlow.Image = "rbxassetid://8992230931"
        ToggleGlow.ImageColor3 = Color3.fromRGB(180, 80, 220)
        ToggleGlow.ImageTransparency = 0.9
        ToggleGlow.ScaleType = Enum.ScaleType.Slice
        ToggleGlow.SliceCenter = Rect.new(100, 100, 100, 100)
        ToggleGlow.ZIndex = -2
        
        -- Tooltip
        local Tooltip = Instance.new("TextLabel")
        Tooltip.Name = "Tooltip"
        Tooltip.Size = UDim2.new(0, 140, 0, 30)
        Tooltip.Position = UDim2.new(1, 10, 0.5, -15)
        Tooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        Tooltip.Text = "Show Password GUI"
        Tooltip.TextColor3 = Color3.fromRGB(255, 240, 150)
        Tooltip.Font = Enum.Font.GothamMedium
        Tooltip.TextSize = 14
        Tooltip.Visible = false
        Tooltip.ZIndex = 1000
        Tooltip.Parent = ToggleButton
        
        Instance.new("UICorner", Tooltip).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", Tooltip).Color = Color3.fromRGB(180, 80, 220)
        
        -- PASSWORD GUI
        local PasswordScreen = Instance.new("ScreenGui")
        PasswordScreen.Name = "PasswordScreen"
        PasswordScreen.ResetOnSpawn = false
        PasswordScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        PasswordScreen.Parent = pgui

        -- Main Password Frame (smaller for mobile)
        local PasswordFrame = Instance.new("Frame")
        PasswordFrame.Size = isMobile and UDim2.new(0, 320, 0, 280) or UDim2.new(0, 380, 0, 300)
        PasswordFrame.Position = UDim2.new(0.5, isMobile and -160 or -190, 0.5, isMobile and -140 or -150)
        PasswordFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        PasswordFrame.BackgroundTransparency = 0
        PasswordFrame.ZIndex = 1000
        PasswordFrame.Visible = false -- Start hidden
        PasswordFrame.Parent = PasswordScreen
        
        Instance.new("UICorner", PasswordFrame).CornerRadius = UDim.new(0, 16)
        
        -- Animated gradient background
        local FrameGrad = Instance.new("UIGradient", PasswordFrame)
        FrameGrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(40, 20, 80)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 30, 120)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(30, 10, 60))
        }
        FrameGrad.Rotation = 45
        
        -- Glowing border
        local FrameStroke = Instance.new("UIStroke", PasswordFrame)
        FrameStroke.Thickness = 4
        FrameStroke.Color = Color3.fromRGB(180, 80, 220)
        FrameStroke.Transparency = 0.3
        FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        -- Dynamic color animation for password frame
        local colorTime = 0
        local colorConnection
        colorConnection = RunService.RenderStepped:Connect(function(delta)
            colorTime = colorTime + delta * 0.5
            local hue = (math.sin(colorTime) * 0.3 + 0.7)
            FrameStroke.Color = Color3.fromHSV(hue, 0.8, 0.9)
            
            local r1 = 40 + math.sin(colorTime * 1.2) * 20
            local g1 = 20 + math.cos(colorTime * 1.5) * 15
            local b1 = 80 + math.sin(colorTime) * 20
            
            local r2 = 60 + math.cos(colorTime) * 30
            local g2 = 30 + math.sin(colorTime * 1.3) * 20
            local b2 = 120 + math.cos(colorTime * 0.8) * 40
            
            FrameGrad.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.0, Color3.fromRGB(r1, g1, b1)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(r2, g2, b2)),
                ColorSequenceKeypoint.new(1.0, Color3.fromRGB(r1/2, g1/2, b1))
            }
            
            -- Also animate toggle button gradient
            local toggleR = 100 + math.sin(colorTime * 1.5) * 30
            local toggleG = 40 + math.cos(colorTime) * 20
            local toggleB = 160 + math.sin(colorTime * 0.7) * 40
            
            ToggleGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.0, Color3.fromRGB(toggleR, toggleG, toggleB)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(toggleR + 80, toggleG + 40, toggleB + 60)),
                ColorSequenceKeypoint.new(1.0, Color3.fromRGB(toggleR, toggleG, toggleB))
            }
        end)

        -- Password Title Bar with close/minimize button
        local PasswordTitleBar = Instance.new("Frame")
        PasswordTitleBar.Size = UDim2.new(1, 0, 0, 45)
        PasswordTitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        PasswordTitleBar.Parent = PasswordFrame
        
        Instance.new("UICorner", PasswordTitleBar).CornerRadius = UDim.new(0, 16)

        local TitleGrad = Instance.new("UIGradient", PasswordTitleBar)
        TitleGrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 40, 160)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 20, 100))
        }

        local PasswordTitle = Instance.new("TextLabel")
        PasswordTitle.Size = UDim2.new(1, -60, 1, 0)
        PasswordTitle.Position = UDim2.new(0, 15, 0, 0)
        PasswordTitle.BackgroundTransparency = 1
        PasswordTitle.Text = "🔒 STARZ PASSWORD SYSTEM"
        PasswordTitle.TextColor3 = Color3.fromRGB(255, 220, 100)
        PasswordTitle.Font = Enum.Font.GothamBlack
        PasswordTitle.TextSize = isMobile and 16 or 18
        PasswordTitle.TextXAlignment = Enum.TextXAlignment.Left
        PasswordTitle.Parent = PasswordTitleBar

        -- Close Button
        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Size = UDim2.new(0, 30, 0, 30)
        CloseBtn.Position = UDim2.new(1, -40, 0.5, -15)
        CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        CloseBtn.Text = "×"
        CloseBtn.TextColor3 = Color3.new(1,1,1)
        CloseBtn.Font = Enum.Font.GothamBlack
        CloseBtn.TextSize = 24
        Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
        CloseBtn.Parent = PasswordTitleBar
        
        local CloseGrad = Instance.new("UIGradient", CloseBtn)
        CloseGrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 100, 100)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 60, 60))
        }

        -- Password Input Area
        local InputContainer = Instance.new("Frame")
        InputContainer.Size = UDim2.new(1, -30, 0, 180)
        InputContainer.Position = UDim2.new(0, 15, 0, 60)
        InputContainer.BackgroundTransparency = 1
        InputContainer.Parent = PasswordFrame

        local PasswordLabel = Instance.new("TextLabel")
        PasswordLabel.Size = UDim2.new(1, 0, 0, 30)
        PasswordLabel.BackgroundTransparency = 1
        PasswordLabel.Text = "Enter Password:"
        PasswordLabel.TextColor3 = Color3.fromRGB(255, 240, 150)
        PasswordLabel.Font = Enum.Font.GothamBold
        PasswordLabel.TextSize = 18
        PasswordLabel.TextXAlignment = Enum.TextXAlignment.Left
        PasswordLabel.Parent = InputContainer

        local PasswordBox = Instance.new("TextBox")
        PasswordBox.Size = UDim2.new(1, 0, 0, 50)
        PasswordBox.Position = UDim2.new(0, 0, 0, 35)
        PasswordBox.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
        PasswordBox.Text = ""
        PasswordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        PasswordBox.Font = Enum.Font.Gotham
        PasswordBox.TextSize = 22
        PasswordBox.PlaceholderText = "Type password here..."
        PasswordBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 200)
        PasswordBox.ClearTextOnFocus = false
        PasswordBox.TextXAlignment = Enum.TextXAlignment.Center
        PasswordBox.TextWrapped = true
        Instance.new("UICorner", PasswordBox).CornerRadius = UDim.new(0, 10)
        PasswordBox.Parent = InputContainer

        local PasswordStroke = Instance.new("UIStroke", PasswordBox)
        PasswordStroke.Thickness = 2
        PasswordStroke.Color = Color3.fromRGB(180, 80, 220)
        PasswordStroke.Transparency = 0.5

        -- Submit Button
        local SubmitBtn = Instance.new("TextButton")
        SubmitBtn.Size = UDim2.new(1, 0, 0, 45)
        SubmitBtn.Position = UDim2.new(0, 0, 0, 100)
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(100, 40, 160)
        SubmitBtn.Text = "🔓 VERIFY & ENTER"
        SubmitBtn.TextColor3 = Color3.new(1,1,1)
        SubmitBtn.Font = Enum.Font.GothamBlack
        SubmitBtn.TextSize = 18
        Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 10)
        SubmitBtn.Parent = InputContainer

        local SubmitGrad = Instance.new("UIGradient", SubmitBtn)
        SubmitGrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 80, 220)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 40, 160))
        }

        local SubmitStroke = Instance.new("UIStroke", SubmitBtn)
        SubmitStroke.Thickness = 2
        SubmitStroke.Color = Color3.fromRGB(255, 200, 100)
        SubmitStroke.Transparency = 0.5

        -- Status Label
        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Size = UDim2.new(1, -30, 0, 25)
        StatusLabel.Position = UDim2.new(0, 15, 0, 250)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "🔐 Attempts remaining: " .. (MAX_ATTEMPTS - passwordAttempts)
        StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
        StatusLabel.Font = Enum.Font.Gotham
        StatusLabel.TextSize = 14
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
        StatusLabel.Parent = PasswordFrame

        -- Hint label
        local HintLabel = Instance.new("TextLabel")
        HintLabel.Size = UDim2.new(1, -30, 0, 20)
        HintLabel.Position = UDim2.new(0, 15, 0, 220)
        HintLabel.BackgroundTransparency = 1
        HintLabel.Text = "Hint: join the dc 🤡"
        HintLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
        HintLabel.Font = Enum.Font.Gotham
        HintLabel.TextSize = 12
        HintLabel.TextXAlignment = Enum.TextXAlignment.Center
        HintLabel.Parent = PasswordFrame

        -- Toggle Password GUI function
        local isPasswordOpen = false
        
        local function TogglePasswordGUI()
            isPasswordOpen = not isPasswordOpen
            
            if isPasswordOpen then
                -- Show password GUI with smooth animation
                PasswordFrame.Visible = true
                PasswordFrame.Position = UDim2.new(-0.5, 0, 0.5, isMobile and -140 or -150)
                PasswordFrame.BackgroundTransparency = 1
                
                -- Animate in from left
                TweenService:Create(PasswordFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.5, isMobile and -160 or -190, 0.5, isMobile and -140 or -150),
                    BackgroundTransparency = 0
                }):Play()
                
                -- Update toggle button
                ToggleButton.Text = "🔒"
                Tooltip.Text = "Hide Password GUI"
                
                -- Focus on password box
                task.wait(0.2)
                PasswordBox:CaptureFocus()
            else
                -- Hide password GUI with smooth animation
                TweenService:Create(PasswordFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Position = UDim2.new(-0.5, 0, 0.5, isMobile and -140 or -150),
                    BackgroundTransparency = 1
                }):Play()
                
                -- Update toggle button
                ToggleButton.Text = "🔑"
                Tooltip.Text = "Show Password GUI"
                
                -- Hide after animation
                task.wait(0.2)
                PasswordFrame.Visible = false
            end
        end

        -- Button connections
        CloseBtn.MouseButton1Click:Connect(TogglePasswordGUI)
        ToggleButton.MouseButton1Click:Connect(TogglePasswordGUI)
        
        -- Make toggle button draggable
        local draggingToggle = false
        local dragStartToggle, startPosToggle
        
        ToggleButton.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or (isMobile and inp.UserInputType == Enum.UserInputType.Touch) then
                draggingToggle = true
                dragStartToggle = inp.Position
                startPosToggle = ToggleButton.Position
                Tooltip.Visible = true
                
                -- Pulse animation when dragging starts
                TweenService:Create(ToggleButton, TweenInfo.new(0.15), {
                    Size = UDim2.new(0, 65, 0, 65)
                }):Play()
            end
        end)
        
        ToggleButton.InputChanged:Connect(function(inp)
            if draggingToggle and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                local delta = inp.Position - dragStartToggle
                ToggleButton.Position = UDim2.new(startPosToggle.X.Scale, startPosToggle.X.Offset + delta.X, startPosToggle.Y.Scale, startPosToggle.Y.Offset + delta.Y)
            end
        end)
        
        ToggleButton.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                draggingToggle = false
                Tooltip.Visible = false
                
                -- Return to normal size
                TweenService:Create(ToggleButton, TweenInfo.new(0.15), {
                    Size = UDim2.new(0, 60, 0, 60)
                }):Play()
            end
        end)

        -- Make password GUI draggable
        local draggingPass = false
        local dragStart, startPos
        
        PasswordTitleBar.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or (isMobile and inp.UserInputType == Enum.UserInputType.Touch) then
                draggingPass = true
                dragStart = inp.Position
                startPos = PasswordFrame.Position
            end
        end)
        
        PasswordTitleBar.InputChanged:Connect(function(inp)
            if draggingPass and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                local delta = inp.Position - dragStart
                PasswordFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        
        PasswordTitleBar.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                draggingPass = false
            end
        end)

        -- Button hover effects for toggle button
        ToggleButton.MouseEnter:Connect(function()
            if not draggingToggle then
                Tooltip.Visible = true
                TweenService:Create(ToggleButton, TweenInfo.new(0.15), {
                    Size = UDim2.new(0, 65, 0, 65)
                }):Play()
                TweenService:Create(ToggleStroke, TweenInfo.new(0.15), {
                    Thickness = 4,
                    Transparency = 0
                }):Play()
                TweenService:Create(ToggleGlow, TweenInfo.new(0.15), {
                    ImageTransparency = 0.7
                }):Play()
            end
        end)
        
        ToggleButton.MouseLeave:Connect(function()
            if not draggingToggle then
                Tooltip.Visible = false
                TweenService:Create(ToggleButton, TweenInfo.new(0.15), {
                    Size = UDim2.new(0, 60, 0, 60)
                }):Play()
                TweenService:Create(ToggleStroke, TweenInfo.new(0.15), {
                    Thickness = 3,
                    Transparency = 0.3
                }):Play()
                TweenService:Create(ToggleGlow, TweenInfo.new(0.15), {
                    ImageTransparency = 0.9
                }):Play()
            end
        end)

        -- Button hover effects for other buttons
        SubmitBtn.MouseEnter:Connect(function()
            TweenService:Create(SubmitBtn, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(180, 80, 220),
                Size = UDim2.new(1.05, 0, 0, 50)
            }):Play()
            TweenService:Create(SubmitStroke, TweenInfo.new(0.15), {
                Transparency = 0
            }):Play()
        end)
        
        SubmitBtn.MouseLeave:Connect(function()
            TweenService:Create(SubmitBtn, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(100, 40, 160),
                Size = UDim2.new(1, 0, 0, 45)
            }):Play()
            TweenService:Create(SubmitStroke, TweenInfo.new(0.15), {
                Transparency = 0.5
            }):Play()
        end)
        
        CloseBtn.MouseEnter:Connect(function()
            TweenService:Create(CloseBtn, TweenInfo.new(0.15), {
                Size = UDim2.new(0, 35, 0, 35),
                Position = UDim2.new(1, -42.5, 0.5, -17.5)
            }):Play()
        end)
        
        CloseBtn.MouseLeave:Connect(function()
            TweenService:Create(CloseBtn, TweenInfo.new(0.15), {
                Size = UDim2.new(0, 30, 0, 30),
                Position = UDim2.new(1, -40, 0.5, -15)
            }):Play()
        end)
        
        PasswordBox.Focused:Connect(function()
            TweenService:Create(PasswordBox, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(35, 35, 55)
            }):Play()
            TweenService:Create(PasswordStroke, TweenInfo.new(0.15), {
                Thickness = 3,
                Transparency = 0.2
            }):Play()
        end)
        
        PasswordBox.FocusLost:Connect(function()
            TweenService:Create(PasswordBox, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(25, 25, 40)
            }):Play()
            TweenService:Create(PasswordStroke, TweenInfo.new(0.15), {
                Thickness = 2,
                Transparency = 0.5
            }):Play()
        end)

        -- Load main UI function (your existing UI)
        function LoadMainUI()
            
            -- STARTS MAIN GUI CODE
            task.spawn(function()
                pcall(function()
                    local Players = game:GetService("Players")
                    local TweenService = game:GetService("TweenService")
                    local UserInputService = game:GetService("UserInputService")
                    local HttpService = game:GetService("HttpService")
                    local player = Players.LocalPlayer
                    local pgui = player:WaitForChild("PlayerGui")

                    -- NOTE: The notification for 'loaded successfully' is now handled by the password script.
                    -- You might want to remove this second notification if you only want it once.
                    -- game.StarterGui:SetCore("SendNotification", {
                    --     Title = "starz by wock";
                    --     Text = "loaded successfully join up bitch, discord.gg/j78zS2USdu";
                    --     Duration = 6;
                    -- })

                    local ScreenGui = Instance.new("ScreenGui")
                    ScreenGui.Name = "StarzByWock"
                    ScreenGui.ResetOnSpawn = false
                    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                    ScreenGui.Parent = pgui

                    -- GOLDEN STAR BUTTON
                    local OpenButton = Instance.new("TextButton")
                    OpenButton.Size = UDim2.new(0, 70, 0, 70)
                    OpenButton.Position = UDim2.new(0, 15, 0.5, -35)
                    OpenButton.BackgroundTransparency = 1
                    OpenButton.Text = ""
                    OpenButton.ZIndex = 999
                    OpenButton.Parent = ScreenGui

                    local StarGrad = Instance.new("UIGradient", OpenButton)
                    StarGrad.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 240, 100)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 180, 0))
                    }
                    StarGrad.Rotation = 45

                    Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(1, 0)
                    local StarStroke = Instance.new("UIStroke", OpenButton)
                    StarStroke.Thickness = 5
                    StarStroke.Color = Color3.fromRGB(255, 220, 80)
                    StarStroke.Transparency = 0.2

                    local StarLabel = Instance.new("TextLabel", OpenButton)
                    StarLabel.Size = UDim2.new(1,0,1,0)
                    StarLabel.BackgroundTransparency = 1
                    StarLabel.Text = "Star"
                    StarLabel.TextColor3 = Color3.new(0,0,0)
                    StarLabel.Font = Enum.Font.GothamBlack
                    StarLabel.TextSize = 44
                    StarLabel.ZIndex = 1000

                    local pulse = TweenService:Create(StarStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.8})

                    -- MAIN FRAME
                    local MainFrame = Instance.new("Frame")
                    MainFrame.Size = UDim2.new(0, 600, 0, 460)
                    MainFrame.Position = UDim2.new(0.5, -300, 1.5, 0)
                    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
                    MainFrame.ClipsDescendants = true
                    MainFrame.BackgroundTransparency = 1
                    MainFrame.ZIndex = 100
                    MainFrame.Parent = ScreenGui

                    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 24)

                    local MainGrad = Instance.new("UIGradient", MainFrame)
                    MainGrad.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(60, 40, 120)),
                        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(40, 30, 100)),
                        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(25, 20, 80)),
                        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(10, 10, 40))
                    }
                    MainGrad.Rotation = 145

                    local GlowStroke = Instance.new("UIStroke", MainFrame)
                    GlowStroke.Thickness = 3
                    GlowStroke.Color = Color3.fromRGB(180, 120, 255)
                    GlowStroke.Transparency = 1
                    GlowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    -- TITLE BAR
                    local TitleBar = Instance.new("Frame")
                    TitleBar.Size = UDim2.new(1, 0, 0, 60)
                    TitleBar.BackgroundColor3 = Color3.fromRGB(255, 180, 40)
                    TitleBar.Parent = MainFrame

                    local TitleGrad = Instance.new("UIGradient", TitleBar)
                    TitleGrad.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 60)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))
                    }
                    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 24)

                    local Title = Instance.new("TextLabel")
                    Title.Size = UDim2.new(1, -100, 1, 0)
                    Title.Position = UDim2.new(0, 20, 0, 0)
                    Title.BackgroundTransparency = 1
                    Title.Text = "starz by wock"
                    Title.TextColor3 = Color3.new(0,0,0)
                    Title.Font = Enum.Font.GothamBlack
                    Title.TextSize = 30
                    Title.TextXAlignment = Enum.TextXAlignment.Left
                    Title.Parent = TitleBar

                    local CloseBtn = Instance.new("TextButton")
                    CloseBtn.Size = UDim2.new(0, 50, 0, 50)
                    CloseBtn.Position = UDim2.new(1, -60, 0, 5)
                    CloseBtn.BackgroundTransparency = 1
                    CloseBtn.Text = "X"
                    CloseBtn.TextColor3 = Color3.fromRGB(220, 50, 50)
                    CloseBtn.Font = Enum.Font.GothamBold
                    CloseBtn.TextSize = 44
                    CloseBtn.Parent = TitleBar

                    -- SIDEBAR
                    local Sidebar = Instance.new("Frame")
                    Sidebar.Size = UDim2.new(0, 150, 1, -60)
                    Sidebar.Position = UDim2.new(0, 0, 0, 60)
                    Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
                    Sidebar.BackgroundTransparency = 1
                    Sidebar.Parent = MainFrame

                    local SidebarList = Instance.new("UIListLayout", Sidebar)
                    SidebarList.Padding = UDim.new(0, 10)
                    SidebarList.SortOrder = Enum.SortOrder.LayoutOrder

                    -- CONTENT AREA
                    local ContentFrame = Instance.new("Frame")
                    ContentFrame.Size = UDim2.new(1, -150, 1, -60)
                    ContentFrame.Position = UDim2.new(0, 150, 0, 60)
                    ContentFrame.BackgroundTransparency = 1
                    ContentFrame.Parent = MainFrame

                    local ContentScroll = Instance.new("ScrollingFrame")
                    ContentScroll.Size = UDim2.new(1, -20, 1, -20)
                    ContentScroll.Position = UDim2.new(0, 10, 0, 10)
                    ContentScroll.BackgroundTransparency = 1
                    ContentScroll.ScrollBarThickness = 5
                    ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(180, 120, 255)
                    ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
                    ContentScroll.CanvasSize = UDim2.new(0,0,0,0)
                    ContentScroll.Parent = ContentFrame

                    local ContentLayout = Instance.new("UIListLayout", ContentScroll)
                    ContentLayout.Padding = UDim.new(0, 12)

                    -- CATEGORIES & BUTTONS (same as before)
                    local Categories = {}
                    local function CreateCategory(name, emoji)
                        local btn = Instance.new("TextButton")
                        btn.Size = UDim2.new(1, -20, 0, 48)
                        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
                        btn.Text = "  " .. emoji .. "  " .. name
                        btn.TextColor3 = Color3.fromRGB(220, 220, 255)
                        btn.Font = Enum.Font.GothamBold
                        btn.TextSize = 17
                        btn.TextXAlignment = Enum.TextXAlignment.Left
                        btn.Parent = Sidebar
                        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

                        local stroke = Instance.new("UIStroke", btn)
                        stroke.Thickness = 1.5
                        stroke.Color = Color3.fromRGB(120, 80, 200)
                        stroke.Transparency = 0.8

                        btn.MouseEnter:Connect(function()
                            if not Categories[btn] then
                                TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(180, 100, 255)}):Play()
                            end
                        end)
                        btn.MouseLeave:Connect(function()
                            if not Categories[btn] then
                                TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 60)}):Play()
                            end
                        end)
                        return btn
                    end

                    local function AddButton(name, callback)
                        local btn = Instance.new("TextButton")
                        btn.Size = UDim2.new(1, 0, 0, 56)
                        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
                        btn.Text = "  " .. name
                        btn.TextColor3 = Color3.fromRGB(230, 230, 255)
                        btn.Font = Enum.Font.GothamBold
                        btn.TextSize = 19
                        btn.TextXAlignment = Enum.TextXAlignment.Left
                        btn.Parent = ContentScroll
                        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 14)

                        local grad = Instance.new("UIGradient", btn)
                        grad.Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 60, 150)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 40, 100))
                        }

                        local stroke = Instance.new("UIStroke", btn)
                        stroke.Thickness = 2
                        stroke.Color = Color3.fromRGB(160, 100, 240)
                        stroke.Transparency = 0.7

                        btn.MouseButton1Click:Connect(callback)
                        btn.MouseEnter:Connect(function()
                            TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(200, 100, 255)}):Play()
                            TweenService:Create(stroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(255, 180, 255), Thickness = 3}):Play()
                            btn.TextColor3 = Color3.new(0,0,0)
                        end)
                        btn.MouseLeave:Connect(function()
                            TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 40, 80)}):Play()
                            TweenService:Create(stroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(160, 100, 240), Thickness = 2}):Play()
                            btn.TextColor3 = Color3.fromRGB(230, 230, 255)
                        end)
                    end

                    local function ClearContent()
                        for _, v in ContentScroll:GetChildren() do
                            if v:IsA("GuiButton") or v:IsA("TextLabel") then v:Destroy() end
                        end
                    end

                    local function SelectCategory(btn)
                        for cat, selected in Categories do
                            if selected then
                                cat.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
                                Categories[cat] = false
                            end
                        end
                        btn.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
                        Categories[btn] = true
                    end

                    -- TABS
                    local HomeTab    = CreateCategory("Home", "🏠")
                    local SabTab     = CreateCategory("Sab", "👻")
                    local BSSTab     = CreateCategory("BSS", "🐝")
                    local MiscTab    = CreateCategory("Misc", "⚙️")
                    local ScriptsTab = CreateCategory("Scripts", "📜")

                    -- TAB CONTENT (same as before)
                    HomeTab.MouseButton1Click:Connect(function()
                        SelectCategory(HomeTab)
                        ClearContent()
                        local t = Instance.new("TextLabel")
                        t.Size = UDim2.new(1,0,0,70); t.BackgroundTransparency = 1
                        t.Text = "starz by wock"; t.TextColor3 = Color3.fromRGB(220,160,255)
                        t.Font = Enum.Font.GothamBlack; t.TextSize = 46; t.Parent = ContentScroll

                        local d = Instance.new("TextLabel")
                        d.Size = UDim2.new(1,0,0,160); d.BackgroundTransparency = 1
                        d.Text = "made by wock all credits too me best free script join up for updates and more shit! \n\ndiscord.gg/j78zS2USdu\n"
                        d.TextColor3 = Color3.fromRGB(200,200,255); d.Font = Enum.Font.Gotham
                        d.TextSize = 22; d.TextWrapped = true; d.Parent = ContentScroll
                    end)

                    SabTab.MouseButton1Click:Connect(function()
                        SelectCategory(SabTab)
                        ClearContent()
                        AddButton("Nameless Hub", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr"))() end)
                        AddButton("Lemon Hub", function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/c4281c3937ebd537cb9e860182e41141.lua"))() end)
                        AddButton("Chilli", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))() end)
                        AddButton("Infinite Yield", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
                    end)

                    BSSTab.MouseButton1Click:Connect(function()
                        SelectCategory(BSSTab)
                        ClearContent()
                        AddButton("Macroware", function() loadstring(game:HttpGet("https://macroware.cc/loader.lua"))() end)
                    end)

                    local fpsBoosted = false
                    local originalSettings = {}

                    MiscTab.MouseButton1Click:Connect(function()
                        SelectCategory(MiscTab)
                        ClearContent()
                        AddButton("Rejoin", function() game:GetService("TeleportService"):Teleport(game.PlaceId, player) end)
                        AddButton("Server Hop", function()
                            local s = game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
                            local l = HttpService:JSONDecode(s)
                            for _,v in l.data do
                                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id, player); break
                                end
                            end
                        end)
                        AddButton("Copy Discord", function() setclipboard("https://discord.gg/j78zS2USdu")
                            game.StarterGui:SetCore("SendNotification",{Title="Copied",Text="discord.gg/j78zS2USdu",Duration=3}) end)
                        AddButton("FPS Boost", function()
                            if fpsBoosted then return end
                            fpsBoosted = true
                            originalSettings.quality = settings().Rendering.QualityLevel
                            for _,v in workspace:GetDescendants() do
                                if v:IsA("BasePart") then
                                    originalSettings[v] = {Material = v.Material, Reflectance = v.Reflectance}
                                    v.Material = Enum.Material.SmoothPlastic
                                    v.Reflectance = 0
                                elseif v:IsA("Decal") or v:IsA("Texture") then
                                    originalSettings[v] = {Transparency = v.Transparency}
                                    v.Transparency = 1
                                end
                            end
                            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                        end)
                        AddButton("UnFPS", function()
                            if not fpsBoosted then return end
                            fpsBoosted = false
                            for obj, props in pairs(originalSettings) do
                                if typeof(obj) == "Instance" and obj.Parent then
                                    if obj:IsA("BasePart") then
                                        obj.Material = props.Material
                                        obj.Reflectance = props.Reflectance
                                    elseif obj:IsA("Decal") or obj:IsA("Texture") then
                                        obj.Transparency = props.Transparency
                                    end
                                end
                            end
                            settings().Rendering.QualityLevel = originalSettings.quality
                            originalSettings = {}
                        end)
                    end)

                    ScriptsTab.MouseButton1Click:Connect(function()
                        SelectCategory(ScriptsTab)
                        ClearContent()
                        AddButton("Prison Life", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/scripture2025/FlashHub/refs/heads/main/PrisonLife"))() end)
                    end)

                    -- DRAG GUI
                    local dragging = false
                    local dragStart, startPos
                    TitleBar.InputBegan:Connect(function(inp)
                        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true; dragStart = inp.Position; startPos = MainFrame.Position
                        end
                    end)
                    TitleBar.InputChanged:Connect(function(inp)
                        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
                            local delta = inp.Position - dragStart
                            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(inp)
                        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                    end)

                    -- STAR DRAG
                    local draggingStar = false
                    local dragStartS, startPosS
                    OpenButton.InputBegan:Connect(function(inp)
                        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                            draggingStar = true; dragStartS = inp.Position; startPosS = OpenButton.Position
                        end
                    end)
                    OpenButton.InputChanged:Connect(function(inp)
                        if draggingStar and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                            local delta = inp.Position - dragStartS
                            OpenButton.Position = UDim2.new(startPosS.X.Scale, startPosS.X.Offset + delta.X, startPosS.Y.Scale, startPosS.Y.Offset + delta.Y)
                        end
                    end)
                    OpenButton.InputEnded:Connect(function() draggingStar = false end)

                    -- PERFECT TOGGLE (click star = open/close)
                    local isOpen = false
                    local function Toggle()
                        isOpen = not isOpen

                        if isOpen then
                            pulse:Pause()
                            StarStroke.Transparency = 0.2

                            -- Click animation
                            TweenService:Create(OpenButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 80, 0, 80)}):Play()
                            task.delay(0.15, function()
                                TweenService:Create(OpenButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 70, 0, 70)}):Play()
                            end)

                            -- Open GUI
                            MainFrame.Position = UDim2.new(0.5, -300, 1.5, 0)
                            MainFrame.BackgroundTransparency = 1

                            TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {
                                Position = UDim2.new(0.5, -300, 0.5, -230),
                                BackgroundTransparency = 0
                            }):Play()
                            TweenService:Create(GlowStroke, TweenInfo.new(0.8), {Transparency = 0.7}):Play()
                            TweenService:Create(Sidebar, TweenInfo.new(0.8), {BackgroundTransparency = 0}):Play()

                            task.wait(0.6)
                            HomeTab.MouseButton1Click:Fire()
                        else
                            pulse:Play()

                            TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {
                                Position = UDim2.new(0.5, -300, 1.5, 0),
                                BackgroundTransparency = 1
                            }):Play()
                            TweenService:Create(GlowStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
                            TweenService:Create(Sidebar, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
                        end
                    end

                    OpenButton.MouseButton1Click:Connect(Toggle)
                    CloseBtn.MouseButton1Click:Connect(Toggle)

                    -- AUTO OPEN
                    task.wait(1)
                    Toggle()
                end)
            end)
            -- ENDS MAIN GUI CODE
            
            print("Password correct! Main UI loaded.")
        end

        -- Password validation function with QUICK kick
        local function ValidatePassword()
            local input = PasswordBox.Text:gsub("%s+", "")  -- Remove whitespace
            
            if input == CORRECT_PASSWORD then
                -- Correct password animation
                TweenService:Create(PasswordBox, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(50, 200, 80)
                }):Play()
                TweenService:Create(SubmitBtn, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(50, 200, 80)
                }):Play()
                SubmitBtn.Text = "✓ ACCESS GRANTED"
                
                -- Fast success animation
                for i = 1, 2 do
                    TweenService:Create(FrameStroke, TweenInfo.new(0.08), {
                        Thickness = 8
                    }):Play()
                    task.wait(0.08)
                    TweenService:Create(FrameStroke, TweenInfo.new(0.08), {
                        Thickness = 4
                    }):Play()
                    task.wait(0.08)
                end
                
                -- Hide password GUI and load main UI
                task.wait(0.3)
                if colorConnection then colorConnection:Disconnect() end -- Stop animation updates
                ToggleScreen:Destroy()
                PasswordScreen:Destroy()
                
                -- CALL THE MAIN UI LOADER
                LoadMainUI() 
                return true
            else
                -- Incorrect password
                passwordAttempts = passwordAttempts + 1
                StatusLabel.Text = "❌ Attempts: " .. passwordAttempts .. "/" .. MAX_ATTEMPTS
                
                -- Fast shake animation
                local startPos = PasswordFrame.Position
                for i = 1, 2 do
                    TweenService:Create(PasswordFrame, TweenInfo.new(0.04), {
                        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + 8, startPos.Y.Scale, startPos.Y.Offset)
                    }):Play()
                    task.wait(0.04)
                    TweenService:Create(PasswordFrame, TweenInfo.new(0.04), {
                        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset - 8, startPos.Y.Scale, startPos.Y.Offset)
                    }):Play()
                    task.wait(0.04)
                end
                TweenService:Create(PasswordFrame, TweenInfo.new(0.08), {
                    Position = startPos
                }):Play()
                
                -- Fast flash red for error
                TweenService:Create(PasswordBox, TweenInfo.new(0.08), {
                    BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                }):Play()
                task.wait(0.08)
                TweenService:Create(PasswordBox, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(25, 25, 40)
                }):Play()
                
                PasswordBox.Text = ""
                
                -- Check if max attempts reached
                if passwordAttempts >= MAX_ATTEMPTS then
                    StatusLabel.Text = "🚫 MAX ATTEMPTS REACHED!"
                    PasswordBox.TextEditable = false
                    SubmitBtn.Text = "🔒 LOCKED"
                    SubmitBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                    
                    -- Fast pulse red warning
                    for i = 1, 3 do
                        TweenService:Create(FrameStroke, TweenInfo.new(0.1), {
                            Color = Color3.fromRGB(255, 50, 50)
                        }):Play()
                        task.wait(0.1)
                        TweenService:Create(FrameStroke, TweenInfo.new(0.1), {
                            Color = Color3.fromRGB(180, 80, 220)
                        }):Play()
                        task.wait(0.1)
                    end
                    
                    -- Show final warning message on the GUI before kicking
                    StatusLabel.Text = "🚫 SHITTY KEY!"
                    HintLabel.Text = "Join DC for real key!"
                    
                    -- QUICK KICK - only 0.5 second delay
                    task.wait(0.5)
                    player:Kick("whoever gave u that key lied they ass off join the dc for the real key")
                else
                    -- Refocus on password box quickly
                    task.wait(0.2)
                    PasswordBox:CaptureFocus()
                end
                return false
            end
        end


        -- Submit button click
        SubmitBtn.MouseButton1Click:Connect(ValidatePassword)
        
        -- Enter key to submit
        PasswordBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                ValidatePassword()
            end
        end)

        -- Initialize with toggle button visible
        task.wait(0.3)
        
        -- Auto-focus on password box periodically if open
        while PasswordScreen and PasswordScreen.Parent do
            task.wait(1.5)
            if isPasswordOpen and PasswordBox then
                PasswordBox:CaptureFocus()
            end
        end
    end)
end)
