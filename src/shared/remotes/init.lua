local Reflex = require("@Packages/Reflex")
local Remo = require("@Packages/Remo")

export type Remotes = {
	reflex: {
		start: Remo.ClientToServer<()>,
		broadcast: Remo.ServerToClient<{ Reflex.BroadcastAction }>,
	},
}

local remotes: Remotes = Remo.createRemotes({
	reflex = Remo.namespace({
		start = Remo.remote(),
		broadcast = Remo.remote(),
	}),
})

return remotes
