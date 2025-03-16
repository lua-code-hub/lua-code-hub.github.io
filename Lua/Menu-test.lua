local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Menu-Lib-Test.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

UI.addGameScript(17625359962, "https://raw.githubusercontent.com/lua-code-hub/lua-code-hub.github.io/refs/heads/main/Lua/Codes/Aim-Test-Code.lua")

UI.addButton("Custom Action", function()
    if game.PlaceId == 17625359962 then
        print(gameName .. " - Started Successfully!")
    else
        print(gameName .. " - Failed (Game Not Supported)")
    end
end)

UI.setTheme(
    Color3.fromRGB(128, 0, 255),
    Color3.fromRGB(75, 0, 130)
)

UI.MenuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
UI.DragBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
