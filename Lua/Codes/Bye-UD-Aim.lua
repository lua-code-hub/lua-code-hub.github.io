-- Add this at the end of your existing code
local function DestroyESP()
    -- Remove all ESP drawings
    for player, esp in pairs(Settings.ESP.Players) do
        for _, drawing in pairs(esp) do
            drawing:Remove()
        end
        Settings.ESP.Players[player] = nil
    end

    -- Remove FOV Circle
    FOVCircle:Remove()

    -- Cleanup connections
    for _, connection in pairs({
        Players.PlayerAdded,
        Players.PlayerRemoving,
        UserInputService.InputBegan,
        RunService.RenderStepped
    }) do
        connection:Disconnect()
    end

    -- Clear settings
    Settings = nil
end

-- Execute cleanup immediately
DestroyESP()
