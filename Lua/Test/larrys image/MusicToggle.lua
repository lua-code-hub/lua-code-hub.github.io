local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MusicControlGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.Parent = player.PlayerGui

-- Create clickable button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 80, 0, 40)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.Text = ""
toggleButton.AutoButtonColor = false
toggleButton.Parent = gui

-- Create sliding indicator
local slider = Instance.new("Frame")
slider.Name = "Slider"
slider.Size = UDim2.new(0.5, -4, 1, -4)
slider.Position = UDim2.new(0, 2, 0, 2)
slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
slider.Parent = toggleButton

-- Add rounded corners
local cornerButton = Instance.new("UICorner")
cornerButton.CornerRadius = UDim.new(1, 0)
cornerButton.Parent = toggleButton

local cornerSlider = Instance.new("UICorner")
cornerSlider.CornerRadius = UDim.new(1, 0)
cornerSlider.Parent = slider

-- Create personal music for this player
local music = Instance.new("Sound")
music.Name = "PersonalMusic"
music.SoundId = "rbxassetid://1848354536"
music.Looped = true
music.Volume = 1
music.Parent = player.PlayerGui

-- Track state
local isPlaying = true

-- Toggle function with animation
local function toggleMusic()
    isPlaying = not isPlaying
    
    if isPlaying then
        slider:TweenPosition(
            UDim2.new(0, 2, 0, 2),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )
        toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        music.SoundId = "rbxassetid://1848354536"
        music:Play()
    else
        slider:TweenPosition(
            UDim2.new(0.5, 2, 0, 2),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        music:Stop()
    end
end

-- Connect the button click
toggleButton.MouseButton1Click:Connect(toggleMusic)

-- Start music for this player
music:Play()
