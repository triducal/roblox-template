local Loader = require("@Packages/Loader")
local Log = require("@Shared/Log")

local function LoadServices()
	local Services = script.Parent.Services
	Loader.SpawnAll(Loader.LoadDescendants(Services, Loader.MatchesName("Service$")), "Init")
end

local function InitializeReflex()
	require("@Server/Store")
end

local function Start()
	InitializeReflex()
	LoadServices()
	Log.info("Server initialized")
end

Start()
