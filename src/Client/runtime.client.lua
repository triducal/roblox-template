local CharmSync = require("@Packages/CharmSync")
local Loader = require("@Packages/Loader")

local Log = require("@Shared/Log")
local Remotes = require("@Shared/Remotes")
local atoms = require("@Shared/Store/atoms")

local function LoadServices()
	local Services = script.Parent.Controllers
	Loader.SpawnAll(Loader.LoadDescendants(Services, Loader.MatchesName("Controller$")), "Init")
end

local function SyncCharm()
	local client = CharmSync.client({ atoms = atoms })

	Remotes.charm.sync:connect(function(payload: CharmSync.SyncPayload)
		client:sync(payload)
	end)

	Remotes.charm.init()
end

local function Start()
	SyncCharm()
	LoadServices()
	Log.info("Server initialized")
end

Start()
