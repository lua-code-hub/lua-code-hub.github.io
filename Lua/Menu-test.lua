local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Codes/Cheat%20Start-Aimbot-Tesr.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local supportedGames = {
    [17625359962] = "https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Codes/Aim-Test-Code.lua",
    [286090429] = "https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Codes/Aim-Test-Code.lua",
}

for gameId, scriptUrl in pairs(supportedGames) do
    UI.addGameScript(gameId, scriptUrl)
end

UI.addButton("Custom Action", function()
    if supportedGames[game.PlaceId] then
        print(gameName .. " - Started Successfully!")
        loadstring(game:HttpGet(supportedGames[game.PlaceId]))()
    else
        print(gameName .. " - Failed (Game Not Supported)")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Codes/Not-Supported.lua"))()
    end
end)

UI.setTheme(
    Color3.fromRGB(128, 0, 255),
    Color3.fromRGB(75, 0, 130)
)

UI.MenuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
UI.DragBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
