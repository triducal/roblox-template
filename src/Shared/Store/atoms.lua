local datastore = require(".").datastore

function flattenAtoms(maps)
	local flattened = {}

	for prefix, map in pairs(maps) do
		for key, atom in pairs(map) do
			flattened[`{prefix}.{key}`] = atom
		end
	end

	return flattened
end

return flattenAtoms({ datastore = datastore })
