local Reflex = require("@Packages/Reflex")
local Sift = require("@Packages/Sift")
local receiverMiddleware = require(script.middleware.receiverMiddleware)
local slices = require("@Shared/Store/slices")

export type RootProducer = Reflex.Producer<RootState, RootActions>
export type RootState = slices.SharedState & {}
export type RootActions = slices.SharedActions & {}

local store: RootProducer = Reflex.combineProducers(Sift.Dictionary.merge(slices, {
	-- Add client-specific slices here
}))

store:applyMiddleware(receiverMiddleware(), Reflex.loggerMiddleware)

return store
