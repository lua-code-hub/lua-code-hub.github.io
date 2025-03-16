local Player = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player.PlayerGui
ScreenGui.Name = "VapeV4Menu"

local MenuFrame = Instance.new("Frame")
MenuFrame.Parent = ScreenGui
MenuFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
MenuFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MenuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MenuFrame.BorderSizePixel = 0
MenuFrame.BackgroundTransparency = 0.1

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MenuFrame
UIListLayout.Padding = UDim.new(0, 10)

-- Function to create the toggle button
local function createButton(name, func, toggleState)
    local button = Instance.new("TextButton")
    button.Parent = MenuFrame
    button.Size = UDim2.new(1, 0, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.BorderSizePixel = 0
    button.BackgroundTransparency = 0.2

    -- When the button is clicked, toggle the feature
    button.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        func(toggleState)  -- Call the corresponding function based on the toggle state
        -- Update button text to reflect on/off state
        if toggleState then
            button.Text = name .. " (On)"
        else
            button.Text = name .. " (Off)"
        end
    end)
end

-- Variables to track the external script and its cleanup logic
local externalScriptEnabled = false
local externalScriptFunction = nil
local externalScriptConnections = {}

-- Function to execute custom code when the script starts
local function onStart()
    print("The external script is starting!")
    -- You can replace this with any custom logic you want to execute when the script starts
    -- Example: Logging, initializing values, etc.
end

-- Function to execute custom code when the script stops
local function onStop()
    print("The external script has stopped!")
    -- You can replace this with any custom cleanup logic you want when the script stops
    -- Example: Resetting variables, removing connections, etc.
end

-- Function to load and execute the external script using loadstring
local function loadExternalScript()
    local url = "https://raw.githubusercontent.com/SYFER-eng/Roblox-Menu-Hub/refs/heads/main/Scripts/UD-Rivals/Tester.lua"

    -- Execute custom code when the script starts
    onStart()

    -- Attempt to execute the external script using loadstring
    local success, errorMessage = pcall(function()
        externalScriptFunction = loadstring(game:HttpGet(url, true))()
    end)

    if not success then
        warn("Error executing external script: " .. errorMessage)
    else
        print("External script executed successfully.")
    end
end

-- Function to stop and clean up the external script
local function stopExternalScript()
    -- Execute custom code when the script stops
    onStop()

    -- If the external script has created any connections (events, listeners), disconnect them
    if externalScriptConnections then
        for _, connection in pairs(externalScriptConnections) do
            if connection.Disconnect then
                connection:Disconnect()
            end
        end
    end

    -- If the external script has any looping or running processes, you would need to stop them
    -- Here you would need to add the actual cleanup logic if the script supports it
    print("Attempting to stop external script...")
    -- Reset tracking variables
    externalScriptConnections = {}
    externalScriptFunction = nil
end

-- Function to toggle the external script
local function toggleExternalScript(isEnabled)
    externalScriptEnabled = isEnabled
    if externalScriptEnabled then
        print("External script enabled.")
        loadExternalScript()  -- Load and execute the external script if enabled
    else
        print("External script disabled.")
        stopExternalScript()  -- Stop the external script and perform cleanup
    end
end

-- Add button for toggling external script
createButton("Toggle Tester Script", toggleExternalScript, externalScriptEnabled)

-- Optional: Add a close button to remove the menu
local closeButton = Instance.new("TextButton")
closeButton.Parent = MenuFrame
closeButton.Size = UDim2.new(0.5, 0, 0, 40)
closeButton.Position = UDim2.new(0.25, 0, 0.85, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Text = "Close"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.BorderSizePixel = 0

-- Close button function
closeButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()  -- Removes the menu
end)
