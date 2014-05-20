local maxStorage = 25

function init(virtual)
	if virtual then return end
	
	-- If amount of honey is nil then set it to 0
	if storage.honey == nil then
		storage.honey = 0
	end
	
	if storage.timer == nil then
		storage.timer = -1
	end
	
	if storage.processing == nil then
		storage.processing = false
	end
end

local function updateTankAnimation()
	local level = storage.honey

	if level == 0 then
		entity.setAnimationState("honeyBottler", "empty")
		return
	end
	
	if level > 0 and level <= 5 then
		entity.setAnimationState("honeyBottler", "fill1")
	elseif level > 5 and level <= 10 then
		entity.setAnimationState("honeyBottler", "fill2")
	elseif level > 10 and level <= 15 then
		entity.setAnimationState("honeyBottler", "fill3")
	elseif level > 15 and level <= 20 then
		entity.setAnimationState("honeyBottler", "fill4")
	elseif level > 20 and level <= 25 then
		entity.setAnimationState("honeyBottler", "fill5")
	end
	
end

function main()
	-- Update inventory
	local inventory = world.containerItems(entity.id())
	
	-- Tick the timer if its greater than 0
	if storage.timer > 0 then
		storage.timer = storage.timer - 1
	end
	
	if storage.timer == 0 then 
		machine.produceItem("beevolution_jarHoney", 1)
		storage.timer = -1
		storage.processing = false
	end
	
	if inventory[1] ~= nil and storage.honey < maxStorage then
		local inputItem = inventory[1].name
		if machineList["honeyBottler"][inputItem] ~= nil then
			local output = machineList["honeyBottler"][inputItem].output
			
			if (output + storage.honey) <= maxStorage then
				machine.consumeItem(1, 1)
				storage.honey = storage.honey + output
				updateTankAnimation()
			end
		end
		
	end
	
	-- Set the animationstate if a jar is available
	if inventory[2]~= nil then
		local honeyContainer = inventory[2].name
		if honeyContainer == "beevolution_jarEmpty" then
			entity.setAnimationState("jar", "empty")
		else
			entity.setAnimationState("jar", "invisible")
			return
		end
	else
		entity.setAnimationState("jar", "invisible")
	end
	
	if storage.honey == 0 or storage.processing or inventory[2] == nil then return end
	
	if storage.honey >= 5 then
		machine.consumeItem(2, 1)
		storage.honey = storage.honey - 5
		storage.processing = true
		storage.timer = 2
		updateTankAnimation()
	end
	
	
end