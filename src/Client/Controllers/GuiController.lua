local Players = game:GetService("Players")
local App = require("@Client/App")
local Log = require("@Shared/Log")
local Vide = require("@Packages/Vide")

local GuiController = {}

function GuiController:Init()
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	Vide.mount(App, PlayerGui)
	Log.info("Mounted App")
end

return GuiController
