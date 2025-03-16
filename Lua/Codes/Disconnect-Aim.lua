    ScreenGui:Destroy()
    
    -- Clean up all drawings
    FOVCircle:Remove()
    for _, esp in pairs(Settings.ESP.Players) do
        for _, drawing in pairs(esp) do
            drawing:Remove()
        end
    end
    
    -- Disconnect all connections
    if autoClickConnection then
        autoClickConnection:Disconnect()
    end
end)
