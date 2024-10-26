local _DataConfig = require("@Shared/Config/data")

local Charm = require("@Packages/Charm")
local Sift = require("@Packages/Sift")

export type PlayerData = typeof(_DataConfig.DefaultData)

local datastore = {
	players = Charm.atom({}) :: Charm.Atom<{ [string]: PlayerData }>,
}

local Players = {}

function Players.getPlayerData(id: string)
	return datastore.players()[id]
end

function Players.setPlayerData(id: string, data: PlayerData)
	datastore.players(function(state)
		return Sift.Dictionary.set(state, id, data)
	end)
end

function Players.deletePlayerData(id: string)
	datastore.players(function(state)
		return Sift.Dictionary.removeKey(state, id)
	end)
end

function Players.updatePlayerData(id: string, updater: (PlayerData) -> PlayerData)
	datastore.players(function(state)
		return Sift.Dictionary.update(state, id, updater)
	end)
end

return {
	datastore = datastore,
	players = Players,
}
