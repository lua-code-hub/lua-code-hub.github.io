local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Wait for player to load
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()

-- Disable movement
local humanoid = character:WaitForChild("Humanoid")
humanoid.WalkSpeed = 0
humanoid.JumpPower = 0

-- Create the loading screen
local LoadingScreen = Instance.new("ScreenGui")
LoadingScreen.Name = "LoadingScreen"
LoadingScreen.Parent = playerGui
LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingScreen.DisplayOrder = 999999999
LoadingScreen.IgnoreGuiInset = true

-- Create UI elements
local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Parent = LoadingScreen
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.Size = UDim2.fromScale(1, 1)
Background.Position = UDim2.fromScale(0, 0)

local LoadingBar = Instance.new("Frame")
LoadingBar.Name = "LoadingBar"
LoadingBar.Parent = Background
LoadingBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LoadingBar.BorderSizePixel = 0
LoadingBar.Position = UDim2.new(0.5, -150, 0.5, -15)
LoadingBar.Size = UDim2.new(0, 300, 0, 30)

local LoadingFill = Instance.new("Frame")
LoadingFill.Name = "LoadingFill"
LoadingFill.Parent = LoadingBar
LoadingFill.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
LoadingFill.BorderSizePixel = 0
LoadingFill.Size = UDim2.new(0, 0, 1, 0)

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "LoadingText"
TextLabel.Parent = Background
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.5, 0, 0.4, 0)
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.Size = UDim2.new(0, 400, 0, 50)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "Loading..."
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 24

local PercentageText = Instance.new("TextLabel")
PercentageText.Name = "Percentage"
PercentageText.Parent = Background
PercentageText.BackgroundTransparency = 1
PercentageText.Position = UDim2.new(0.5, 0, 0.6, 0)
PercentageText.AnchorPoint = Vector2.new(0.5, 0.5)
PercentageText.Size = UDim2.new(0, 400, 0, 50)
PercentageText.Font = Enum.Font.GothamBold
PercentageText.Text = "0%"
PercentageText.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentageText.TextSize = 20

-- Loading animation
local loadingSteps = {
    "Loading Assets",
    "Preparing Game",
    "Initializing Systems",
    "Almost Ready",
    "Finishing Up"
}

local function updateLoadingBar(percentage)
    local fillTween = TweenService:Create(LoadingFill, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad), 
        {Size = UDim2.new(percentage/100, 0, 1, 0)}
    )
    fillTween:Play()
    PercentageText.Text = percentage.."%"
end

-- Run loading sequence
for i, step in ipairs(loadingSteps) do
    TextLabel.Text = step.."..."
    local startPercent = (i-1) * 20
    local endPercent = i * 20
    
    for percent = startPercent, endPercent do
        updateLoadingBar(percent)
        task.wait(0.05)
    end
end

-- Re-enable movement
humanoid.WalkSpeed = 16
humanoid.JumpPower = 50

-- Fade out animation
task.wait(0.5)
local fadeOut = TweenService:Create(Background,
    TweenInfo.new(1),
    {BackgroundTransparency = 1}
)
fadeOut:Play()

for _, child in pairs(Background:GetDescendants()) do
    if child:IsA("TextLabel") then
        TweenService:Create(child,
            TweenInfo.new(1),
            {TextTransparency = 1}
        ):Play()
    elseif child:IsA("Frame") then
        TweenService:Create(child,
            TweenInfo.new(1),
            {BackgroundTransparency = 1}
        ):Play()
    end
end

task.wait(1)
LoadingScreen:Destroy()
