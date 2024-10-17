local Players = game:GetService("Players")

local Selectors = require("@Shared/store/selectors")
local Store = require("@Server/store")

function setupLeaderstats(player: Player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local coins = Instance.new("NumberValue")
	coins.Parent = leaderstats
	coins.Name = "Coins"

	local gems = Instance.new("NumberValue")
	gems.Name = "Gems"
	gems.Parent = leaderstats

	local selector = Selectors.selectPlayerBalance(tostring(player.UserId))
	local unsubscribe = Store:subscribe(selector, function(balance)
		coins.Value = balance.coins or 0
		gems.Value = balance.gems or 0
	end)
	Players.PlayerRemoving:Connect(function(leavingPlayer: Player)
		if leavingPlayer == player then
			unsubscribe()
		end
	end)
end

local LeaderstatService = {}

function LeaderstatService:Init()
	Players.PlayerAdded:Connect(setupLeaderstats)
	for _, player in Players:GetPlayers() do
		setupLeaderstats(player)
	end
end

return LeaderstatService
