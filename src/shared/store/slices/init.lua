local players = require(script.players)

export type SharedState = {
	players: players.PlayersState,
}

export type SharedActions = players.PlayersActions

return {
	players = players,
}
