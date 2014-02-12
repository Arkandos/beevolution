
beevolution_breed = {}
speciesList = {"forest", "desert", "icey"}


function beevolution_breed.gather()
	local itemIds = world.itemDropQuery(entity.position(), 1)
	for k, v in ipairs(itemIds) do
		if world.entityName(v) == beevolution_breed.getDrone("forest") then
			local drone = world.takeItemDrop(v)
		elseif world.entityName(v) == beevolution_breed.getPrincess("forest") then
			local princess = world.takeItemDrop(v)
		end
		
		if drone ~= nil and princess ~= nil then
			world.spawnItem(beevolution_breed.getQueen("forest"), entity.position(), {species1 = }
			
			drone = nil
			princess = nil
		end
		
	end

end

function beevolution_breed.getDrone(species)
	return "beevolution_"..speciesList[species].."drone")
end

function beevolution_breed.getPrincess(species)
	return "beevolution_"..speciesList[species].."princess")
end

function beevolution_breed.getQueen(species)
	return "beevolution_"..speciesList[species].."queen")
end

function beevolution_breed.getBeeName(_beename)

end