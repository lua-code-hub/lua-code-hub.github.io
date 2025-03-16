local UISystem = {}

-- Protection and Secure Loading
function UISystem.createProtectedGui()
    local success, ProtectedGui = pcall(function()
        local ScreenGui = Instance.new("ScreenGui")
        if syn and syn.protect_gui then
            syn.protect_gui(ScreenGui)
        end
        
        local parent = (syn and syn.protect_gui and gethui()) or (gethui and gethui()) or (get_hidden_gui and get_hidden_gui()) or game:GetService("CoreGui")
        
        ScreenGui.Name = tostring(math.random(1000000, 9999999))
        ScreenGui.DisplayOrder = 999999999
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.Parent = parent
        return ScreenGui
    end)
    return success and ProtectedGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- Initialize core components
function UISystem.init()
    UISystem.ScreenGui = UISystem.createProtectedGui()
    UISystem.setupServices()
    UISystem.createInterface()
    return UISystem
end

-- Setup core services
function UISystem.setupServices()
    UISystem.Player = game.Players.LocalPlayer
    UISystem.UserInputService = game:GetService("UserInputService")
    UISystem.TweenService = game:GetService("TweenService")
    UISystem.MarketplaceService = game:GetService("MarketplaceService")
    UISystem.mouse = UISystem.Player:GetMouse()
end

-- Game Scripts Database
UISystem.gameScripts = {
    ["default"] = "https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Codes/Universal-Script.lua",
    [17625359962] = "https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Codes/Aim-Test-Code.lua",
}

-- Create main interface
function UISystem.createInterface()
    -- Create Enhanced Blur Effect
    local blur = Instance.new("BlurEffect")
    blur.Parent = game.Lighting
    blur.Size = 0
    UISystem.blur = blur

    -- Main Frame
    local MenuFrame = Instance.new("Frame")
    MenuFrame.Parent = UISystem.ScreenGui
    MenuFrame.Size = UDim2.new(0.15, 0, 0.2, 0)
    MenuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MenuFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MenuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MenuFrame.BorderSizePixel = 0
    MenuFrame.BackgroundTransparency = 1
    MenuFrame.ClipsDescendants = true
    UISystem.MenuFrame = MenuFrame

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
    UISystem.UIStroke = UIStroke

    -- Animated Stroke Color
    coroutine.wrap(function()
        while wait() do
            for i = 0, 1, 0.01 do
                UIStroke.Color = Color3.fromHSV(i, 0.7, 1)
                wait(0.03)
            end
        end
    end)()

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
    local gameName = UISystem.MarketplaceService:GetProductInfo(game.PlaceId).Name
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = DragBar
    TitleLabel.Size = UDim2.new(1, 0, 1, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "Syfer-eng - " .. gameName
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.Gotham
    TitleLabel.TextSize = 14

    -- Create Main Button
    UISystem.createMainButton()

    -- Enable Dragging
    UISystem.enableDragging(MenuFrame, DragBar)

    -- Initialize UI with Enhanced Animation
    UISystem.enhancedFadeIn(MenuFrame)
end

-- Ripple Effect Function
function UISystem.createRipple(button, x, y)
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

    UISystem.TweenService:Create(ripple, TweenInfo.new(0.5), {
        Size = targetSize,
        Position = targetPos,
        BackgroundTransparency = 1
    }):Play()

    game.Debris:AddItem(ripple, 0.5)
end

-- Enhanced Animation Functions
function UISystem.enhancedFadeIn(object)
    local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back)
    UISystem.TweenService:Create(object, tweenInfo, {
        BackgroundTransparency = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    UISystem.TweenService:Create(UISystem.blur, tweenInfo, {Size = 15}):Play()
end

-- Script Loading Function
function UISystem.loadScript()
    local gameId = game.PlaceId
    local scriptUrl = UISystem.gameScripts[gameId] or UISystem.gameScripts["default"]
    loadstring(game:HttpGet(scriptUrl, true))()
end

-- Create Main Button
function UISystem.createMainButton()
    local mainButton = Instance.new("TextButton")
    mainButton.Parent = UISystem.MenuFrame
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

    UISystem.setupMainButtonEvents(mainButton)
    UISystem.mainButton = mainButton
end

-- Setup Main Button Events
function UISystem.setupMainButtonEvents(mainButton)
    mainButton.MouseEnter:Connect(function()
        UISystem.TweenService:Create(mainButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(80, 80, 255)
        }):Play()
    end)

    mainButton.MouseLeave:Connect(function()
        UISystem.TweenService:Create(mainButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 255)
        }):Play()
    end)

    mainButton.MouseButton1Click:Connect(function()
        UISystem.createRipple(mainButton, UISystem.mouse.X, UISystem.mouse.Y)
        UISystem.handleMainButtonClick()
    end)
end

-- Handle Main Button Click
function UISystem.handleMainButtonClick()
    for _, child in pairs(UISystem.MenuFrame:GetChildren()) do
        if child:IsA("UIGradient") then continue end
        child:Destroy()
    end

    local loadingText = Instance.new("TextLabel")
    loadingText.Parent = UISystem.MenuFrame
    loadingText.Size = UDim2.new(1, 0, 0.5, 0)
    loadingText.Position = UDim2.new(0, 0, 0.25, 0)
    loadingText.BackgroundTransparency = 1
    loadingText.Text = "Starting. . ."
    loadingText.TextSize = 16
    loadingText.Font = Enum.Font.Gotham
    loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)

    local progressBar = UISystem.createProgressBar()
    UISystem.animateProgressAndLoad(progressBar)
end

-- Create Progress Bar
function UISystem.createProgressBar()
    local progressBar = Instance.new("Frame")
    progressBar.Parent = UISystem.MenuFrame
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

    return progress
end

-- Animate Progress and Load
function UISystem.animateProgressAndLoad(progress)
    UISystem.TweenService:Create(progress, TweenInfo.new(2), {
        Size = UDim2.new(1, 0, 1, 0)
    }):Play()

    wait(2)
    UISystem.loadScript()
    wait(0.3)
    UISystem.blur:Destroy()
    UISystem.ScreenGui:Destroy()
end

-- Enable Dragging
function UISystem.enableDragging(frame, handle)
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

    UISystem.UserInputService.InputChanged:Connect(function(input)
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

-- Add new script to database
function UISystem.addGameScript(gameId, scriptUrl)
    UISystem.gameScripts[gameId] = scriptUrl
end

-- Custom script loader
function UISystem.loadCustomScript(scriptUrl)
    loadstring(game:HttpGet(scriptUrl, true))()
end

-- Modify UI theme
function UISystem.setTheme(primaryColor, secondaryColor)
    UISystem.mainButton.BackgroundColor3 = primaryColor
    UISystem.UIStroke.Color = secondaryColor
end

-- Add custom button
function UISystem.addButton(name, callback)
    local newButton = UISystem.mainButton:Clone()
    newButton.Text = name
    newButton.Parent = UISystem.MenuFrame
    newButton.Position = UDim2.new(0.05, 0, 0.6, 0)
    newButton.MouseButton1Click:Connect(callback)
    return newButton
end

return UISystem.init()
