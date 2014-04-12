function init(virtual)
	
	if vitual then return end
	
	if storage.timer == nil then
		storage.timer = 300
	end
	
	-- Check if the beehouse is above ground
	if not isAboveGround() then
		return { "ShowPopup", { message = "The little bees need a clear line of sight of the sky!"} }
	end
	
end


function main()
	-- Update the inventory
	local inventory = world.containerItems(entity.id())
	
	-- If the inputslot is empty then return
	if inventory[1] == nil then return end
	if storage.timer == 0 then
		storage.timer = 500
	end
	
	-- Update the time of day. 0 - 0.5 is day. 0.5 - 1 is night.
	local day = world.timeOfDay()
	
	-- If there is something in inventoryslot 2
	if inventory[2] ~= nil then
		-- If the item is something named princess, then consume the princess and a drone to make a queen
		if string.find(inventory[1].name, "princess") ~= nil and string.find(inventory[2].name, "drone") ~= nil then
			if getSpecies(inventory[1].name) == getSpecies(inventory[2].name) then
				if spawnQueen(inventory[1].name) then
					machine.consumeItem(1, 1)
					machine.consumeItem(2, 1)
					--world.containerTakeNumItemsAt(entity.id(), 1, 1)
					--world.containerTakeNumItemsAt(entity.id(), 2, 1)
					return
				end
			end
		end
	end
	
	
	
	if string.find(inventory[1].name, "queen") ~= nil then
		if storage.timer > 0 then
			if day >= 0 and day < 0.5 then
				storage.timer = storage.timer - 1
				if storage.timer < 0 then storage.timer = 0 end
			end
		end
		
		local species = getSpecies(inventory[1].name)
		if storage.timer == 10 then
					local productChance = math.random(0, 100)
					if beeList[species].productivity.chance <= productChance then
						machine.produceItem(beeList[species].produce, math.random(beeList[species].productivity.min, beeList[species].productivity.max))
					end
					local specialChance = math.random(0, 100)
					if beeList[species].specialProductivity.chance <= specialChance then
						machine.produceItem(beeList[species].specialProduce, math.random(beeList[species].specialProductivity.min, beeList[species].specialProductivity.max))
					end
					--machine.produceItem("beevolution_combHoney", honeyCount)
					--machine.produceItem("beevolution_pollenNormal", pollenCount)
					--world.containerAddItems(entity.id(), { name = "beevolution_combHoney", count = honeyCount, data = {}})
					--world.containerAddItems(entity.id(), { name = "beevolution_pollenNormal", count = pollenCount, data = {}})
		elseif storage.timer < 10 then
			if spawnOffspring(inventory[1].name) then
				storage.timer = beeList[species].lifeSpan
			else
				storage.timer = 10
			end
		end
	end
end

-- Get the species of a bee. [WIP] To be moved to a central lua file
function getSpecies(beename)
	local queen, qStop = string.find(beename, "queen")
	local princess, pStop = string.find(beename, "princess")
	local drone, dStop = string.find(beename, "drone")
	
	if queen ~= nil then
		return string.sub(beename, qStop + 1)
	elseif princess ~= nil then
		return string.sub(beename, pStop + 1)
	elseif drone ~= nil then
		return string.sub(beename, dStop + 1)
	end
end

-- Spawn a queen of a certain species
function spawnQueen(beename)
	if  world.containerItemsCanFit(entity.id(), { name = "beevolution_queen"..getSpecies(beename), count = 1, data = {} }) == 1 then
		world.containerAddItems(entity.id(), { name = "beevolution_queen"..getSpecies(beename), count = 1, data = {} })
		return true
	else
		return false
	end
end

-- Spawn 1 princess and (fertility) 
function spawnOffspring(queen, fertility)
	if fertility == nil then
		fertility = 2
	end
	
	local princess = "beevolution_princess"..getSpecies(queen)
	local drone = "beevolution_drone"..getSpecies(queen)
	
	if world.containerItemsCanFit(entity.id(), { name = princess, count = 1, data = {} }) and world.containerItemsCanFit(entity.id(), { name = drone, count = fertility, data = {} }) then
		machine.produceItem(princess, 1)
		machine.produceItem(drone, fertility)
		machine.consumeItem(1, 1)
		return true
	end
	
	return false
end

function isAboveGround()
	if world.underground(entity.position()) then
		return false
	end
	
	local ll = entity.toAbsolutePosition({ -4.0, 1.0 })
	local tr = entity.toAbsolutePosition({ 4.0, 32.0 })
  
	local bounds = {0, 0, 0, 0}
	bounds[1] = ll[1]
	bounds[2] = ll[2]
	bounds[3] = tr[1]
	bounds[4] = tr[2]
  
	return not world.rectCollision(bounds, true)
end