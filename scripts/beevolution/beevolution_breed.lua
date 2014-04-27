breed = {}
local inventory = {}
local init = false

-- Should be called before every other function to properly update the inventory
function updateInventory()
	inventory = world.containerItems(entity.id())
	if inventory == nil then return false else return true end
end

-- Get the type of item provided. If it is not a bee, return false
function breed.getType( itemName )
	if string.find(itemName, "drone") ~= nil then
		return "drone"
	elseif string.find(itemName, "princess") ~= nil then
		return "princess"
	elseif string.find(itemName, "queen") ~= nil then
		return "queen"
	end
	
	return false
end

function breed.getSpecies( beeName )
	local queen, qStop = string.find(beeName, "queen")
	local princess, pStop = string.find(beeName, "princess")
	local drone, dStop = string.find(beeName, "drone")
	
	if queen ~= nil then
		return string.sub(beeName, qStop + 1)
	elseif princess ~= nil then
		return string.sub(beeName, pStop + 1)
	elseif drone ~= nil then
		return string.sub(beeName, dStop + 1)
	end

end

-- The main breeding function
function breed.breed( princess, drone, multiplier )
	local pSpecies = breed.getSpecies( princess )
	local dSpecies = breed.getSpecies( drone )
	local pNatural = beeList[pSpecies].natural
	local dNatural = beeList[dSpecies].natural
	
	if multiplier == nil then multiplier = 1 end
	
	local n = false
	
	if pNatural or dNatural then
		n = true
	end
	
	for child, param in pairs(beeBranches) do
		if param.species1 == pSpecies or param.species1 == dSpecies or param.species1 == "natural" and n == true then	
			if param.species2 == pSpecies or param.species2 == dSpecies or param.species2 == "natural" and n == true then
				local c = math.random(0, 100)
				
				if c <= ( param.chance * multiplier ) then
					breed.spawnQueen(child)
					return
				end
			end
		end
	end
	
	local n = math.random(1, 2)
	if n == 1 then
		breed.spawnQueen(pSpecies)
	else
		breed.spawnQueen(dSpecies)
	end
end

-- Spawn 1 princess and (fertility) drones
function breed.spawnOffspring(queen, fertility)
	if fertility == nil then
		fertility = 2
	end
	
	local princess = "beevolution_princess"..breed.getSpecies(queen)
	local drone = "beevolution_drone"..breed.getSpecies(queen)
	
	if world.containerItemsCanFit(entity.id(), { name = princess, count = 1, data = {} }) and world.containerItemsCanFit(entity.id(), { name = drone, count = fertility, data = {} }) then
		machine.produceItem(princess, 1)
		machine.produceItem(drone, fertility)
		machine.consumeItem(1, 1)
		return true
	end
	
	return false
end

-- Consume a drone and a princess to spawn a queen
function breed.spawnQueen( species )
	if world.containerItemsCanFit(entity.id(), { name = "beevolution_queen"..species, count = 1, data = {} }) == 1 then
		world.containerAddItems(entity.id(), { name = "beevolution_queen"..species, count = 1, data = {} })
		machine.consumeItem(1, 1)
		machine.consumeItem(2, 1)
		return true
	else
		return false
	end
end