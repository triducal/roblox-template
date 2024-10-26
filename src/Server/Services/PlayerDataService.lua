local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local DataConfig = require("@Shared/Config/data")
local Datastore = require("@Shared/Store")
local Log = require("@Shared/Log")

local Charm = require("@Packages/Charm")
local Lapis = require("@Packages/Lapis")
local MockDataStore = require("@Packages/MockDataStore")
local Promise = require("@Packages/Promise")
local t = require("@Packages/t")

Lapis.setConfig({
	dataStoreService = RunService:IsStudio() and MockDataStore or DataStoreService,
})

local collection = Lapis.createCollection(DataConfig.StoreKey, {
	defaultData = DataConfig.DefaultData,
	validate = t.strictInterface(DataConfig.Validation),
})

local function syncToCharm(player: Player, document: Lapis.Document<Datastore.PlayerData>)
	local unsubscribe = Charm.effect(function()
		local data = Datastore.players.getPlayerData(player.Name)

		if data then
			document:write(data)
		end
	end)

	Datastore.players.setPlayerData(player.Name, document:read())

	Log.info(`Synced {player.Name}'s data to Charm.`)

	Promise.fromEvent(Players.PlayerRemoving, function(left: Player)
		return left == player
	end)
		:andThen(function()
			return unsubscribe()
		end)
		:andThen(function()
			return document:close()
		end)
end

local function onPlayerAdded(player: Player)
	collection
		:load(`Player{player.UserId}`, { player.UserId })
		:andThen(function(document)
			if player.Parent == nil then
				-- The player might have left before the document finished loading.
				-- The document needs to be closed because PlayerRemoving won't fire at this point.
				document:close():catch(warn)
				return
			end

			syncToCharm(player, document)
		end)
		:catch(function(message)
			if not RunService:IsStudio() then
				warn(`Player {player.Name}'s data failed to load: {message}`)
			end

			Datastore.players.setPlayerData(player.Name, DataConfig.DefaultData)
		end)
end

local function onPlayerRemoving(player: Player)
	Datastore.players.deletePlayerData(player.Name)
end

local DataService = {}

function DataService:Init()
	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(onPlayerRemoving)

	for _, player in Players:GetPlayers() do
		onPlayerAdded(player)
	end
end

return DataService
