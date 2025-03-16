local UI = loadstring(game:HttpGet("path_to_enhanced_ui.lua"))()

-- Add custom game script
UI.addGameScript(12345, "https://example.com/script.lua")

-- Add custom button
UI.addButton("Custom Action", function()
    print("Custom action triggered!")
end)

-- Change theme colors
UI.setTheme(
    Color3.fromRGB(128, 0, 255),
    Color3.fromRGB(75, 0, 130)
)

-- For a more complete theme update, you can also add:
UI.MenuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
UI.DragBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
