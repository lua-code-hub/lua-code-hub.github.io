local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(0, 6)
CloseButtonCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    
    -- Clean up all drawings
    FOVCircle:Remove()
    for _, esp in pairs(Settings.ESP.Players) do
        for _, drawing in pairs(esp) do
            drawing:Remove()
        end
    end
    
    -- Disconnect all connections
    if autoClickConnection then
        autoClickConnection:Disconnect()
    end
end)

-- Create Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -80, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = TitleBar

local MinimizeButtonCorner = Instance.new("UICorner")
MinimizeButtonCorner.CornerRadius = UDim.new(0, 6)
MinimizeButtonCorner.Parent = MinimizeButton

local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TabContainer.Visible = false
        TabButtons.Visible = false
        MainFrame:TweenSize(UDim2.new(0, 500, 0, 50), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
        MinimizeButton.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 500, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
        wait(0.5)
        TabContainer.Visible = true
        TabButtons.Visible = true
        MinimizeButton.Text = "-"
    end
end)

-- Create a function to show/hide the UI
local function ToggleUI()
    ScreenGui.Enabled = not ScreenGui.Enabled
end

-- Connect key press events
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        -- Toggle UI with INSERT key
        if input.KeyCode == Enum.KeyCode.Insert then
            ToggleUI()
        end
        
        -- Close UI with END key
        if input.KeyCode == Enum.KeyCode.End then
            CloseButton.MouseButton1Click:Fire()
        end
        
        -- Check for toggle keys
        if toggleKeys[input.KeyCode] then
            toggleKeys[input.KeyCode]()
        end
        
        -- Track mouse buttons for auto clicker
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isLeftMouseDown = true
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            isRightMouseDown = true
            -- Set target player when right mouse is pressed
            targetPlayer = GetClosestPlayerToMouse()
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isLeftMouseDown = false
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            isRightMouseDown = false
            targetPlayer = nil
        end
    end
end)

-- Create ESP for all players
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        CreateESP(player)
    end
end

-- Create ESP for new players
Players.PlayerAdded:Connect(function(player)
    if player ~= localPlayer then
        CreateESP(player)
    end
end)

-- Remove ESP for players who leave
Players.PlayerRemoving:Connect(function(player)
    if Settings.ESP.Players[player] then
        for _, drawing in pairs(Settings.ESP.Players[player]) do
            drawing:Remove()
        end
        Settings.ESP.Players[player] = nil
    end
end)

-- NoClip functionality
RunService.Stepped:Connect(function()
    if noClipEnabled and localPlayer.Character then
        for _, part in pairs(localPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Main loop for aimbot and ESP
RunService.RenderStepped:Connect(function()
    -- Update FOV Circle position
    FOVCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    FOVCircle.Visible = Settings.Aimbot.ShowFOV
    FOVCircle.Radius = Settings.Aimbot.FOV
    
    -- Update ESP
    UpdateESP()
    
    -- Aimbot logic
    if Settings.Aimbot.Enabled and isRightMouseDown then
        local target = GetClosestPlayerToMouse()
        if target and target.Character and target.Character:FindFirstChild(Settings.Aimbot.TargetPart) then
            local targetPart = target.Character[Settings.Aimbot.TargetPart]
            
            -- Apply prediction if target is moving
            local velocity = target.Character.HumanoidRootPart.Velocity
            local predictionOffset = velocity * Settings.Aimbot.PredictionMultiplier * 0.1
            local targetPosition = targetPart.Position + predictionOffset
            
            -- Convert 3D position to 2D screen position
            local screenPosition, onScreen = camera:WorldToViewportPoint(targetPosition)
            
            if onScreen then
                local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                local aimPosition = Vector2.new(screenPosition.X, screenPosition.Y)
                local mousePosition = UserInputService:GetMouseLocation()
                
                -- Calculate distance and apply smoothing
                local distance = (aimPosition - mousePosition).Magnitude
                local smoothness = Settings.Aimbot.Smoothness
                
                if distance > 5 then
                    local aimDelta = (aimPosition - mousePosition) * smoothness
                    mousemoverel(aimDelta.X, aimDelta.Y)
                end
                
                -- TriggerBot functionality
                if Settings.Aimbot.TriggerBot then
                    local ray = camera:ScreenPointToRay(screenCenter.X, screenCenter.Y)
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                    raycastParams.FilterDescendantsInstances = {localPlayer.Character}
                    
                    local raycastResult = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)
                    if raycastResult and raycastResult.Instance:IsDescendantOf(target.Character) then
                        mouse1click()
                    end
                end
            end
        end
    end
    
    -- Silent Aim logic
    if AimSettings.SilentAim and isLeftMouseDown then
        local target = GetClosestPlayerToMouse()
        if target and target.Character and target.Character:FindFirstChild(AimSettings.TargetPart) then
            -- Implement hit chance
            if math.random(1, 100) <= AimSettings.HitChance then
                perfectAim(target.Character[AimSettings.TargetPart])
            end
        end
    end
end)

-- Create notification function
function createNotification(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration,
        Icon = "rbxassetid://13647654264"
    })
end
