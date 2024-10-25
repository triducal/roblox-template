local Loader = require("@Packages/Loader")
local Log = require("@Shared/Log")

local function LoadServices()
	local Services = script.Parent.Services
	Loader.SpawnAll(Loader.LoadDescendants(Services, Loader.MatchesName("Service$")), "Init")
end

local function Start()
	LoadServices()
	Log.info("Server initialized")
end

Start()
