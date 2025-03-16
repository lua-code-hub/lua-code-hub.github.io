local function createPopup()
    local Player = game.Players.LocalPlayer
    local TweenService = game:GetService("TweenService")
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = Player.PlayerGui
    
    -- Create Popup Frame
    local PopupFrame = Instance.new("Frame")
    PopupFrame.Size = UDim2.new(0, 250, 0, 80)
    PopupFrame.Position = UDim2.new(0.5, -125, 0.8, 0)
    PopupFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    PopupFrame.BorderSizePixel = 0
    PopupFrame.Parent = ScreenGui
    
    -- Add Corner
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = PopupFrame
    
    -- Add Stroke
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(255, 50, 50)
    UIStroke.Thickness = 2
    UIStroke.Parent = PopupFrame
    
    -- Add Text
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "Game Not Supported"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextSize = 18
    TextLabel.Parent = PopupFrame
    
    -- Animate In
    PopupFrame.Position = UDim2.new(0.5, -125, 1.2, 0)
    local tweenIn = TweenService:Create(PopupFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -125, 0.8, 0)
    })
    tweenIn:Play()
    
    -- Animate Out and Destroy
    wait(1.5)
    local tweenOut = TweenService:Create(PopupFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -125, 1.2, 0)
    })
    tweenOut:Play()
    
    tweenOut.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end

createPopup()
