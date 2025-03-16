-- Services and Player Setup
local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local mouse = Player:GetMouse()

-- Load Supported Games from External Source
local supportedGames = loadstring(game:HttpGet("https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Codes/Supported-Games.lua"))()

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player.PlayerGui
ScreenGui.Name = "EnhancedOwlMenu"
ScreenGui.Enabled = true

-- Create Enhanced Blur Effect
local blur = Instance.new("BlurEffect")
blur.Parent = game.Lighting
blur.Size = 0

-- Main Frame
local MenuFrame = Instance.new("Frame")
MenuFrame.Parent = ScreenGui
MenuFrame.Size = UDim2.new(0.15, 0, 0.2, 0)
MenuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MenuFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MenuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MenuFrame.BorderSizePixel = 0
MenuFrame.BackgroundTransparency = 1
MenuFrame.ClipsDescendants = true

-- Enhanced Gradient
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 25)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
})
UIGradient.Parent = MenuFrame

-- Animated Gradient
local gradientRotation = 0
game:GetService("RunService").Heartbeat:Connect(function()
    gradientRotation = gradientRotation + 1
    UIGradient.Rotation = gradientRotation
end)

-- Enhanced Corner and Stroke
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MenuFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 80, 255)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.5
UIStroke.Parent = MenuFrame

-- Animated Stroke Color
local function animateStroke()
    while wait() do
        for i = 0, 1, 0.01 do
            UIStroke.Color = Color3.fromHSV(i, 0.7, 1)
            wait(0.03)
        end
    end
end
coroutine.wrap(animateStroke)()

-- Enhanced Drag Bar
local DragBar = Instance.new("Frame")
DragBar.Parent = MenuFrame
DragBar.Size = UDim2.new(1, 0, 0, 30)
DragBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
DragBar.BorderSizePixel = 0

local DragBarCorner = Instance.new("UICorner")
DragBarCorner.CornerRadius = UDim.new(0, 10)
DragBarCorner.Parent = DragBar

-- Enhanced Title Label with Game Name
local gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = DragBar
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Syfer-eng - " .. gameName
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.Gotham
TitleLabel.TextSize = 14

-- Ripple Effect Function
local function createRipple(button, x, y)
    local ripple = Instance.new("Frame")
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.6
    ripple.BorderSizePixel = 0
    ripple.Position = UDim2.new(0, x - button.AbsolutePosition.X, 0, y - button.AbsolutePosition.Y)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Parent = button
    
    local rippleCorner = Instance.new("UICorner")
    rippleCorner.CornerRadius = UDim.new(1, 0)
    rippleCorner.Parent = ripple
    
    local targetSize = UDim2.new(2, 0, 2, 0)
    local targetPos = UDim2.new(-0.5, x - button.AbsolutePosition.X, -0.5, y - button.AbsolutePosition.Y)
    
    TweenService:Create(ripple, TweenInfo.new(0.5), {
        Size = targetSize,
        Position = targetPos,
        BackgroundTransparency = 1
    }):Play()
    
    game.Debris:AddItem(ripple, 0.5)
end

-- Enhanced Animation Functions
local function enhancedFadeIn(object)
    local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back)
    TweenService:Create(object, tweenInfo, {
        BackgroundTransparency = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    TweenService:Create(blur, tweenInfo, {Size = 15}):Play()
end

-- Script Loading Function with Enhanced Game Detection
local function loadScript()
    local gameId = game.PlaceId
    if supportedGames[gameId] then
        print(gameName .. " - Started Successfully!")
        loadstring(game:HttpGet(supportedGames[gameId], true))()
    else
        print(gameName .. " - Failed (Game Not Supported)")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Codes/Not-Supported.lua", true))()
    end
end

-- Create Main Button
local mainButton = Instance.new("TextButton")
mainButton.Parent = MenuFrame
mainButton.Size = UDim2.new(0.9, 0, 0.5, 0)
mainButton.Position = UDim2.new(0.05, 0, 0.4, 0)
mainButton.BackgroundColor3 = Color3.fromRGB(60, 60, 255)
mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainButton.Text = "Start"
mainButton.Font = Enum.Font.Gotham
mainButton.TextSize = 18
mainButton.BorderSizePixel = 0
mainButton.BackgroundTransparency = 0.1
mainButton.ClipsDescendants = true

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = mainButton

-- Button Events
mainButton.MouseEnter:Connect(function()
    TweenService:Create(mainButton, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(80, 80, 255)
    }):Play()
end)

mainButton.MouseLeave:Connect(function()
    TweenService:Create(mainButton, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(60, 60, 255)
    }):Play()
end)

mainButton.MouseButton1Click:Connect(function()
    createRipple(mainButton, mouse.X, mouse.Y)
    
    for _, child in pairs(MenuFrame:GetChildren()) do
        if child ~= UIGradient then
            child:Destroy()
        end
    end
    
    local loadingText = Instance.new("TextLabel")
    loadingText.Parent = MenuFrame
    loadingText.Size = UDim2.new(1, 0, 0.5, 0)
    loadingText.Position = UDim2.new(0, 0, 0.25, 0)
    loadingText.BackgroundTransparency = 1
    loadingText.Text = "Starting. . ."
    loadingText.TextSize = 16
    loadingText.Font = Enum.Font.Gotham
    loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local progressBar = Instance.new("Frame")
    progressBar.Parent = MenuFrame
    progressBar.Size = UDim2.new(0.8, 0, 0.05, 0)
    progressBar.Position = UDim2.new(0.1, 0, 0.6, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    progressBar.BorderSizePixel = 0
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 4)
    progressCorner.Parent = progressBar
    
    local progress = Instance.new("Frame")
    progress.Parent = progressBar
    progress.Size = UDim2.new(0, 0, 1, 0)
    progress.BackgroundColor3 = Color3.fromRGB(60, 60, 255)
    progress.BorderSizePixel = 0
    
    local progressInnerCorner = Instance.new("UICorner")
    progressInnerCorner.CornerRadius = UDim.new(0, 4)
    progressInnerCorner.Parent = progress
    
    TweenService:Create(progress, TweenInfo.new(2), {
        Size = UDim2.new(1, 0, 1, 0)
    }):Play()
    
    wait(2)
    loadScript()
    wait(0.3)
    blur:Destroy()
    ScreenGui:Destroy()
end)

-- Enable Dragging
local function enableDragging(frame, handle)
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Initialize Dragging
enableDragging(MenuFrame, DragBar)

-- Initialize UI with Enhanced Animation
enhancedFadeIn(MenuFrame)
