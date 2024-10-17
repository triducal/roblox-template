local Lapis = require("@Packages/Lapis")
local Types = require("@Shared/store/slices/players/types")
local t = require("@Packages/t")

local template: Types.PlayerData = {
	balance = {
		coins = 0,
		gems = 0,
	},
	inventory = {
		pets = {},
	},
}

local validate = t.interface({
	balance = t.interface({
		coins = t.number,
		gems = t.number,
	}),
	inventory = t.interface({
		pets = t.map(
			t.string,
			t.interface({
				equipped = t.boolean,
			})
		),
	}),
})

local config: Lapis.CollectionOptions<Types.PlayerData> = {
	defaultData = template,
	validate = validate,
	migrations = {},
}

return config
