local Reflex = require("@Packages/Reflex")
local remotes = require("@Shared/Remotes")

local function receiverMiddleware()
	local receiver = Reflex.createBroadcastReceiver({
		start = function(): ()
			remotes.reflex.start()
		end,
	})

	remotes.reflex.broadcast:connect(function(actions)
		receiver:dispatch(actions)
	end)

	return receiver.middleware
end

return receiverMiddleware
