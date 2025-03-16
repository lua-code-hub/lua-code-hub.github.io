local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local mouse = Player:GetMouse()


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player.PlayerGui
ScreenGui.Name = "EnhancedSyferMenu"
ScreenGui.Enabled = true


local blur = Instance.new("BlurEffect")
blur.Parent = game.Lighting
blur.Size = 0


local dragging
local dragInput
local dragStart
local startPos


local MenuFrame = Instance.new("Frame")
MenuFrame.Parent = ScreenGui
MenuFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
MenuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MenuFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MenuFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MenuFrame.BorderSizePixel = 0
MenuFrame.BackgroundTransparency = 1
MenuFrame.ClipsDescendants = true


local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 40))
})
UIGradient.Parent = MenuFrame


local gradientRotation = 0
game:GetService("RunService").Heartbeat:Connect(function()
    gradientRotation = gradientRotation + 1
    UIGradient.Rotation = gradientRotation
end)


local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MenuFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(100, 100, 255)
UIStroke.Thickness = 2
UIStroke.Parent = MenuFrame


local function animateStroke()
    while wait() do
        for i = 0, 1, 0.01 do
            UIStroke.Color = Color3.fromHSV(i, 1, 1)
            wait(0.03)
        end
    end
end
coroutine.wrap(animateStroke)()


local DragBar = Instance.new("Frame")
DragBar.Parent = MenuFrame
DragBar.Size = UDim2.new(1, 0, 0, 30)
DragBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
DragBar.BorderSizePixel = 0

local DragBarCorner = Instance.new("UICorner")
DragBarCorner.CornerRadius = UDim.new(0, 10)
DragBarCorner.Parent = DragBar


local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = DragBar
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Enhanced Syfer Menu"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 16


local keybindButton = Instance.new("TextButton")
keybindButton.Parent = MenuFrame
keybindButton.Size = UDim2.new(0.3, 0, 0, 30)
keybindButton.Position = UDim2.new(0.67, 0, 0.93, 0)
keybindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
keybindButton.Font = Enum.Font.GothamBold
keybindButton.TextSize = 14
keybindButton.BorderSizePixel = 0
keybindButton.ClipsDescendants = true

local keybindCorner = Instance.new("UICorner")
keybindCorner.CornerRadius = UDim.new(0, 6)
keybindCorner.Parent = keybindButton


local toggleKey = Enum.KeyCode.Insert
keybindButton.Text = "Toggle: " .. toggleKey.Name


local changing = false
keybindButton.MouseButton1Click:Connect(function()
    changing = true
    keybindButton.Text = "Press any key..."
    
    local connection
    connection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            toggleKey = input.KeyCode
            keybindButton.Text = "Toggle: " .. toggleKey.Name
            changing = false
            connection:Disconnect()
        end
    end)
end)


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

local function createEnhancedButton(name, onFunc, offFunc)
    local button = Instance.new("TextButton")
    button.Parent = MenuFrame
    button.Size = UDim2.new(0.9, 0, 0, 50)
    button.Position = UDim2.new(0.05, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.BorderSizePixel = 0
    button.BackgroundTransparency = 0.1
    button.ClipsDescendants = true
    
    local toggleState = false
    local hoverDebounce = false
    local originalColor = Color3.fromRGB(40, 40, 50)
    local greenColor = Color3.fromRGB(60, 180, 100)
    local redColor = Color3.fromRGB(180, 60, 60)
    
    button.MouseEnter:Connect(function()
        hoverDebounce = true
        local targetColor = toggleState and greenColor or redColor
        TweenService:Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = targetColor
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        hoverDebounce = false
        wait(0.1)
        TweenService:Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = originalColor
        }):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        createRipple(button, mouse.X, mouse.Y)
        
        if toggleState then
            onFunc()
            button.Text = name .. " (On)"
        else
            offFunc()
            button.Text = name .. " (Off)"
        end
        
        if not hoverDebounce then
            TweenService:Create(button, TweenInfo.new(0.3), {
                BackgroundColor3 = originalColor
            }):Play()
        end
    end)
end


local function enhancedFadeIn(object)
    local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back)
    TweenService:Create(object, tweenInfo, {
        BackgroundTransparency = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    TweenService:Create(blur, tweenInfo, {Size = 15}):Play()
end

local function enhancedFadeOut(object)
    local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    TweenService:Create(object, tweenInfo, {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    TweenService:Create(blur, tweenInfo, {Size = 0}):Play()
end


local function loadOnScript()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Codes/Aim-Test-Code.lua", true))()
end

local function loadOffScript()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Codes/Bye-Aim.lua", true))()
end


createEnhancedButton("Test Aim Script", loadOnScript, loadOffScript)


local closeButton = Instance.new("TextButton")
closeButton.Parent = MenuFrame
closeButton.Size = UDim2.new(0.5, 0, 0, 40)
closeButton.Position = UDim2.new(0.25, 0, 0.85, 0)
closeButton.BackroundColor3 = Color3.fromRGB(220, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Text = "Close"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.BorderSizePixel = 0
closeButton.ClipsDescendants = true

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    createRipple(closeButton, mouse.X, mouse.Y)
    enhancedFadeOut(MenuFrame)
    wait(0.6)
    blur:Destroy()
    ScreenGui:Destroy()
end)

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


enableDragging(MenuFrame, DragBar)


UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not changing and input.KeyCode == toggleKey then
        ScreenGui.Enabled = not ScreenGui.Enabled
        if ScreenGui.Enabled then
            enhancedFadeIn(MenuFrame)
        else
            enhancedFadeOut(MenuFrame)
        end
    elseif input.KeyCode == Enum.KeyCode.End then
        enhancedFadeOut(MenuFrame)
        wait(0.6)
        blur:Destroy()
        ScreenGui:Destroy()
    end
end)


enhancedFadeIn(MenuFrame)
