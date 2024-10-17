local Loader = require("@Packages/Loader")
local Log = require("@Shared/Log")

local function LoadServices()
	local Services = script.Parent.controllers
	Loader.SpawnAll(Loader.LoadDescendants(Services, Loader.MatchesName("Controller$")), "Init")
end

local function InitializeReflex()
	require("@Server/store")
end

local function Start()
	InitializeReflex()
	LoadServices()
	Log.info("Server initialized")
end

Start()
