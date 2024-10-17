local Reflex = require("@Packages/Reflex")
local Sift = require("@Packages/Sift")
local Types = require(script.Parent.types)

type BalanceProducer = Reflex.Producer<BalanceState, BalanceActions>

export type BalanceState = {
	[string]: Types.PlayerBalance?,
}

export type BalanceActions = {
	loadPlayerData: (playerId: string, data: Types.PlayerData) -> (),
	closePlayerData: (playerId: string) -> (),
	updateBalance: (playerId: string, balanceType: Types.PlayerBalanceType, amount: number) -> (),
}

local initialState: BalanceState = {}

local balanceSlice: BalanceProducer = Reflex.createProducer(initialState, {
	loadPlayerData = function(state, id: string, data: Types.PlayerData)
		return Sift.Dictionary.set(state, id, data.balance)
	end,

	closePlayerData = function(state, id: string)
		return Sift.Dictionary.removeKey(state, id)
	end,

	updateBalance = function(state, id: string, balanceType: Types.PlayerBalanceType, amount: number)
		return Sift.Dictionary.update(state, id, function(balance: Types.PlayerBalance?): Types.PlayerBalance?
			if not balance then
				return
			end

			return Sift.Dictionary.set(balance, balanceType, balance[balanceType] + amount)
		end)
	end,
})

return balanceSlice
