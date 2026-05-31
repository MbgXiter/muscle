-- 📍 GAME CONFIGURATION - Place in ServerScriptService

local Config = require(game.ServerStorage:WaitForChild("Config"))
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

print("✅ Game configured and ready!")
print("Players can now join and start playing.")