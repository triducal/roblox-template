local RunService = game:GetService("RunService")
local t = require("@Packages/t")

local _version = RunService:IsStudio() and "DEV" or "PROD"
local key = "0.0.1"

local Data = {
	StoreKey = `{_version}{key}`,
	PlayerKey = "Player_",

	DefaultData = {
		Cash = 0,
	},

	Validation = {
		Cash = t.integer,
	},
}

return Data
