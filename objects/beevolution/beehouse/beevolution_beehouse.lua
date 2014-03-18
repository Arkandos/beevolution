function init(virtual)
	
	--[[if vitual then return end
	entity.setInteractive(true)
	--]]
	
	if storage.timer == nil then
		storage.timer = 300
	end
	
end

function main()
	world.logInfo("Running main function of beevolution_beehouse")
	local day = world.timeOfDay()
	local inventory = world.containerItems(entity.id())
	if storage.timer == 0 then
		storage.timer = 500
	end
	
	if storage.timer > 0 then
		if day >= 0 and day < 0.5 then
			storage.timer = storage.timer - 1
			if storage.timer < 0 then storage.timer = 0 end
		end
	end
	
	if string.find(inventory[1].name, "princess") ~= nil and string.find(inventory[2].name, "drone") ~= nil then
		if storage.timer == 10 then
			if getSpecies(inventory[1].name) == "Forest" then
				if world.containerItemsCanFit(entity.id(), {name = "beevolution_combHoney", count = 1, data = {}}) == 1 and world.containerItemsCanFit(entity.id(), {name = "beevolution_pollenNormal", count = 1, data = {}}) == 1 then
					local honeyCount = math.random(5)
					local pollenCount = math.random(0, 3)
					world.containerAddItems(entity.id(), { name = "beevolution_combHoney", count = honeyCount, data = {}})
					world.containerAddItems(entity.id(), { name = "beevolution_pollenNormal", count = pollenCount, data = {}})
				end
			end
		elseif storage.timer < 10 then
			if spawnQueen(inventory[1].name) then
				world.containerConsume(1)
			end
		end
	end
end

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

function spawnQueen(beename)
	if  world.containerItemsCanFit(entity.id(), { name = "beevolution_queen"..getSpecies(beename), count = 1, data = {}}) == 1 then
		world.containerAddItems(entity.id(), { name = "beevolution_queen"..getSpecies(beename), count = 1, data = {}})
		return true
	else
		return false
	end
end