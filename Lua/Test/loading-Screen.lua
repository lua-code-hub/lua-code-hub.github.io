local LoadingScreen = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local Image = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")

LoadingScreen.Name = "LoadingScreen"
LoadingScreen.Parent = game.CoreGui
LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingScreen.DisplayOrder = 999999999
LoadingScreen.IgnoreGuiInset = true

Background.Name = "Background"
Background.Parent = LoadingScreen
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.Size = UDim2.fromScale(1, 1)
Background.Position = UDim2.fromScale(0, 0)

Image.Name = "Image"
Image.Parent = Background
Image.BackgroundTransparency = 1
Image.Position = UDim2.fromScale(0.5, 0.5)
Image.AnchorPoint = Vector2.new(0.5, 0.5)
Image.Size = UDim2.fromOffset(200, 200)
Image.Image = "rbxassetid://83497866000186"

TextLabel.Name = "GameTitle"
TextLabel.Parent = Background
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.5, 0, 0.7, 0)
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.Size = UDim2.new(0, 400, 0, 50)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "Syfer-eng - " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
TextLabel.TextSize = 24

local TweenService = game:GetService("TweenService")

-- Epic pulsing effect (without spin)
spawn(function()
    local startSize = UDim2.fromOffset(200, 200)
    local endSize = UDim2.fromOffset(300, 300)
    local pulseCount = 0
    
    while pulseCount < 2 and LoadingScreen.Parent do
        TweenService:Create(Image, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = endSize
        }):Play()
        wait(0.5)
        
        TweenService:Create(Image, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Size = startSize
        }):Play()
        wait(0.5)
        
        pulseCount = pulseCount + 1
    end
end)

-- Rainbow text effect
spawn(function()
    while LoadingScreen.Parent do
        for i = 0, 1, 0.01 do
            TextLabel.TextColor3 = Color3.fromHSV(i, 1, 1)
            wait()
        end
    end
end)

wait(2)

-- Smooth fade out (without spin)
TweenService:Create(Background, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(Image, TweenInfo.new(1), {
    ImageTransparency = 1,
    Size = UDim2.fromOffset(400, 400)
}):Play()
TweenService:Create(TextLabel, TweenInfo.new(1), {TextTransparency = 1}):Play()

wait(1)
LoadingScreen:Destroy()
