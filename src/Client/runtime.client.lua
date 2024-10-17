local Loader = require("@Packages/Loader")
local Log = require("@Shared/Log")

local function LoadServices()
	local Services = script.Parent.Controllers
	Loader.SpawnAll(Loader.LoadDescendants(Services, Loader.MatchesName("Controller$")), "Init")
end

local function InitializeReflex()
	require("@Client/Store")
end

local function Start()
	InitializeReflex()
	LoadServices()
	Log.info("Server initialized")
end

Start()
