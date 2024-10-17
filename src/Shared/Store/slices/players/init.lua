local Reflex = require("@Packages/Reflex")
local Types = require(script.types)
local balance = require(script.balance)
local inventory = require(script.inventory)

export type PlayerData = Types.PlayerData
export type PlayerBalance = Types.PlayerBalance
export type PlayerInventory = Types.PlayerInventory

type PlayersProducer = Reflex.Producer<PlayersState, PlayersActions>

export type PlayersState = {
	balance: balance.BalanceState,
	inventory: inventory.InventoryState,
}

export type PlayersActions = balance.BalanceActions & inventory.InventoryActions

local playersSlice: PlayersProducer = Reflex.combineProducers({
	balance = balance,
	inventory = inventory,
})

return playersSlice
