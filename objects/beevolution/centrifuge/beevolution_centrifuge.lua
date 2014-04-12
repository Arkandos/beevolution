function init(virtual)
	if virtual then return end
	
	if storage.fuel == nil then
		storage.fuel = 0
	end
	
	if storage.timer == nil then
		storage.timer = -1
	end
end

function main()
	local inventory = world.containerItems(entity.id())
	
	if storage.timer > 0 then
		storage.timer = storage.timer - 1
	end
	
	if storage.timer == 0 then
		for k, v in pairs(storage.output) do
			machine.produceItem(k, v)
		end
		storage.timer = -1
		storage.output = {}
	end
	
	if inventory[2] ~= nil then
		local fuelItem = inventory[2].name
		if storage.fuel <= 120 then machine.refuel(2, 1) end
	end
	
	if inventory[1] == nil then return end
	local inputItem = inventory[1].name
	
	if machineList["centrifuge"][inputItem] ~= nil then
		local fuelCost = machineList["centrifuge"][inputItem].fuelCost
		if storage.fuel >= fuelCost then
			machine.consumeFuel(fuelCost)
			machine.consumeItem(1, 1)
			storage.timer = machineList["centrifuge"][inputItem].time
			storage.output = {}
			
			for k, v in pairs(machineList["centrifuge"][inputItem].output) do
				local c = math.random(0, 100)
				local amount = 0
				if c <= v.chance then
					amount = math.random(v.min, v.max)
				end
				storage.output[k] = amount
			end
		else
			machine.refuel(1, 1)
		end
	end
	
end

