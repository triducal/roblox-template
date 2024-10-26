local Players = game:GetService("Players")

local CharmVide = require("@Packages/CharmVide")
local Datastore = require("@Shared/Store")

local function useCash()
	return CharmVide.useAtom(function()
		local data = Datastore.players.getPlayerData(Players.LocalPlayer.Name)

		return data and data.Cash or 0
	end)
end

return useCash
