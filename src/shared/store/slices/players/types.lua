export type PlayerData = {
	balance: PlayerBalance,
	inventory: PlayerInventory,
}

export type PlayerBalance = {
	gems: number,
	coins: number,
}

export type PlayerBalanceType = "gems" | "coins"

export type PlayerInventory = {
	pets: { [string]: PlayerInventoryPet },
}

export type PlayerInventoryPet = {
	equipped: boolean,
}

return nil
