local Reflex = require("@Packages/Reflex")
local remotes = require("@Shared/remotes")
local slices = require("@Shared/store/slices")

local function broadcasterMiddleware()
	local broadcaster = Reflex.createBroadcaster({
		producers = slices,
		dispatch = function(player, actions)
			remotes.reflex.broadcast(player, actions)
		end,
	})

	remotes.reflex.start:connect(function(player)
		return broadcaster:start(player)
	end)

	return broadcaster.middleware
end

return broadcasterMiddleware
