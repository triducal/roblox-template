local Workspace = game:GetService("Workspace")

local Vide = require("@Packages/Vide")

-- Constants
local BASE_RESOLUTION = Vector2.new(1280, 832)
local MIN_SCALE = 0.5
local DOMINANT_AXIS = 0.5

-- Scale variable
local scale = Vide.source(1)

-- Function to create a callable object
local function callable(callback, object)
	return setmetatable(object, {
		__call = function(_, ...)
			return callback(...)
		end,
	})
end

-- Create px callable object
local px = callable(function(value)
	return math.round(value * scale())
end, {
	even = function(value: number)
		return math.round(value * scale() * 0.5) * 2
	end,
	scale = function(value: number)
		return value * scale()
	end,
	floor = function(value: number)
		return math.floor(value * scale())
	end,
	ceil = function(value: number)
		return math.ceil(value * scale())
	end,
})

-- Function to update scale based on viewport size
local function usePx()
	local camera = Workspace.CurrentCamera

	local function updateScale()
		local width = math.log(camera.ViewportSize.X / BASE_RESOLUTION.X, 2)
		local height = math.log(camera.ViewportSize.Y / BASE_RESOLUTION.Y, 2)
		local centered = width + (height - width) * DOMINANT_AXIS

		scale(math.max(2 ^ centered, MIN_SCALE))
	end

	local connection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

	Vide.cleanup(connection)

	-- Update scale and clean up connection
	updateScale()
end

return {
	px = px,
	usePx = usePx,
}
