local Reflex = require("@Packages/Reflex")
local Sift = require("@Packages/Sift")
local broadcasterMiddleware = require(script.middleware.broadcasterMiddleware)
local slices = require("@Shared/Store/slices")

export type RootProducer = Reflex.Producer<RootState, RootActions>
export type RootState = slices.SharedState & {}
export type RootActions = slices.SharedActions & {}

local store: RootProducer = Reflex.combineProducers(Sift.Dictionary.merge(slices, {
	-- Add server-specific slices here
}))

store:applyMiddleware(broadcasterMiddleware(), Reflex.loggerMiddleware)

return store
