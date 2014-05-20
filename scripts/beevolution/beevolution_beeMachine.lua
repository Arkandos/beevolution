beeMachine = {}
local inventory = {}

-- Should be called before every other function to properly update the inventory
function beeMachine.updateInventory()
	inventory = world.containerItems(entity.id())
	if inventory == nil then return false else return true end
end

function beeMachine.main( canBreed, args )
	beeMachine.updateInventory()
	
	if canBreed == nil then canBreed = true end
	if args == nil then 
		productionMultiplier = 1 
		breedMultiplier = 1
		fuelConsumption = 0
	else
		productionMultiplier = args.productionMultiplier
		breedMultiplier = args.breedMultiplier
		
		if args.fuelConsumption == nil then
			fuelConsumption = 0
		else
			fuelConsumption = args.fuelConsumption
			fuelSlot = args.fuelSlot
		end
	end
	
	-- If the inputslot is empty then return
	if inventory[1] == nil then return end
	-- Update the time of day. 0 - 0.5 is day. 0.5 - 1 is night.
	local day = world.timeOfDay()
	
	-- If there is something in inventoryslot 2
	if inventory[2] ~= nil then
		if breed.getType(inventory[1].name) == "princess" and breed.getType(inventory[2].name) == "drone" then
			-- If the princess and the drone is the same species, do not conduct breeding procedures
			if breed.getSpecies(inventory[1].name) == breed.getSpecies(inventory[2].name) then
				if breed.spawnQueen( breed.getSpecies(inventory[1].name) ) then
					return
				end
			else
				if canBreed then
					breed.breed(inventory[1].name, inventory[2].name, breedMultiplier)
				end
			end
		end		
	end
	
	-- If there is a queen in slot 1 then tick the timer
	if breed.getType(inventory[1].name) == "queen" then
		local species = breed.getSpecies(inventory[1].name)
		local activity = beeList[species].activity
		
		if storage.timer == 0 or storage.timer == nil then
			storage.timer = beeList[species].lifeSpan
		end
		
		-- Tick the timer if the bee is active during current time
		if storage.timer > 0 then
			if fuelConsumption > 0 then	
				if not beeMachine.powered(fuelConsumption, fuelSlot) then return end
			end
			
			if activity == "day" then
				if day >= 0 and day < 0.5 then
					storage.timer = storage.timer - 1
						
				end
			elseif activity == "night" then
				if day >= 0.5 and day <= 1 then
					storage.timer = storage.timer - 1
				end
			elseif activity == "both" then
				storage.timer = storage.timer - 1
			end
			
			
			if storage.timer < 0 then storage.timer = 0 end
		end
		
		-- If the timer is 10, produce items and spawn offspring
		if storage.timer == 10 then
			local productChance = math.random(100)
			local specialChance = math.random(100)
			
			if beeList[species].productivity.chance <= productChance then
				machine.produceItem(beeList[species].produce, math.floor(math.random(beeList[species].productivity.min, beeList[species].productivity.max) * productionMultiplier ))
			end
			
			if beeList[species].specialProductivity.chance <= specialChance then
				machine.produceItem(beeList[species].specialProduce, math.floor(math.random(beeList[species].specialProductivity.min, beeList[species].specialProductivity.max) * productionMultiplier ))
			end
		elseif storage.timer < 10 then
			if breed.spawnOffspring(inventory[1].name, beeList[species].fertility) then
				storage.timer = 0
			else
				storage.timer = 10
			end
		end
	end
end

function beeMachine.powered( amount, slot )
	if amount == 0 then return true end
	if storage.fuel == nil then storage.fuel = 0 end
	
	if storage.fuelTick == nil then storage.fuelTick = 0 end
	
	storage.fuelTick = storage.fuelTick + 1
	
	if storage.fuelTick >= 100 then 
		if storage.fuel >= amount then
			machine.consumeFuel( amount )
			storage.fuelTick = 0
			return true
		else
			if machine.refuel( slot, amount ) then return true end
		end
	
	end
	
	return true
end

