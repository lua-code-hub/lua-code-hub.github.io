local function DestroyESP()
    for _, esp in pairs(Settings.ESP.Players) do
        for _, drawing in pairs(esp) do
            drawing:Remove()
        end
    end
    Settings.ESP.Players = {}
    FOVCircle:Remove()
end

DestroyESP()
