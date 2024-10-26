local Players = game:GetService("Players")

local Charm = require("@Packages/Charm")
local Datastore = require("@Shared/Store")

local LeaderstatsService = {}

function LeaderstatsService:Init()
	Charm.observe(Datastore.datastore.players, function(_, name)
		local player = Players:FindFirstChild(name)

		if not player then
			return
		end

		local leaderstats = Instance.new("Folder")

		leaderstats.Name = "leaderstats"
		leaderstats.Parent = player

		local cash = Instance.new("IntValue")

		cash.Name = "💸 Cash"
		cash.Parent = leaderstats

		local unsubscribe = Charm.effect(function()
			local data = Datastore.players.getPlayerData(name)

			cash.Value = data and data.Cash or 0
		end)

		return unsubscribe
	end)
end

return LeaderstatsService
