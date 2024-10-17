local Sift = require("@Packages/Sift")
local players = require(script.players)

return Sift.Dictionary.merge(players) :: typeof(players)
