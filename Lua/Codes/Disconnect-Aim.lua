local CoreGui = game:GetService("CoreGui")
local ScreenGui = CoreGui:FindFirstChild("RivalsEnhancedGUI")

if ScreenGui then
    ScreenGui:Destroy()
    
    -- Clean up all drawings
    if FOVCircle then
        FOVCircle:Remove()
    end
    
    if Settings and Settings.ESP and Settings.ESP.Players then
        for _, esp in pairs(Settings.ESP.Players) do
            for _, drawing in pairs(esp) do
                drawing:Remove()
            end
        end
    end
    
    -- Disconnect all connections
    if autoClickConnection then
        autoClickConnection:Disconnect()
    end
end
