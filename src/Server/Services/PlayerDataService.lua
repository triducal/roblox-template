local Players = game:GetService("Players")

local Lapis = require("@Packages/Lapis")
local Promise = require("@Packages/Promise")
local dataConfig = require("@Shared/Config/data")
local selectors = require("@Shared/Store/selectors")
local store = require("@Server/Store")

local collection = Lapis.createCollection("data-v1", dataConfig)

local function loadDefaultData(player: Player)
	store.loadPlayerData(player.Name, dataConfig.defaultData)

	return Promise.fromEvent(Players.PlayerRemoving, function(playerLeft: Player)
		return player == playerLeft
	end):andThen(function()
		store.closePlayerData(player.Name)
	end)
end

local function loadPlayerData(player: Player)
	if player.UserId < 0 then
		-- Lapis session locking may break in local test servers, which use
		-- negative user IDs, so we just load the default data instead.
		return loadDefaultData(player)
	end

	return collection
		:load(`{player.UserId}`)
		:andThen(function(document)
			if not player:IsDescendantOf(Players) then
				document:close()
				return
			end

			local unsubscribe = store:subscribe(selectors.selectPlayerData(player.Name), function(data)
				if data then
					document:write(data)
				end
			end)

			Promise.fromEvent(Players.PlayerRemoving, function(playerLeft: Player)
				return player == playerLeft
			end):andThen(function()
				unsubscribe()
				document:close():finally(function()
					store.closePlayerData(player.Name)
				end)
			end)

			store.loadPlayerData(player.Name, document:read())
		end)
		:catch(function(err)
			warn(`Failed to load data for player {player.Name}: {err}`)
			return loadDefaultData(player)
		end)
end

local PlayerDataService = {}

function PlayerDataService:Init()
	Players.PlayerAdded:Connect(function(player: Player)
		loadPlayerData(player)
	end)

	for _, player in Players:GetPlayers() do
		loadPlayerData(player)
	end
end

return PlayerDataService
