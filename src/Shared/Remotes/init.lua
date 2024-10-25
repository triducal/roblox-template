local CharmSync = require("@Packages/CharmSync")
local Remo = require("@Packages/Remo")

export type Remotes = {
	charm: {
		sync: Remo.ServerToClient<CharmSync.SyncPayload>,
		init: Remo.ClientToServer<()>,
	},
}

local remotes: Remotes = Remo.createRemotes({
	charm = Remo.namespace({
		sync = Remo.remote(),
		init = Remo.remote(),
	}),
})

return remotes
