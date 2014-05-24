machine = {}
local inventory = {}
local fuelList = { coalore = 40 }



-- Should be called before every other function to properly update the inventory
function machine.updateInventory()
	inventory = world.containerItems( entity.id() )
	if inventory == nil then return false else return true end
end

-- Make entity consume an item
function machine.consumeItem(slot, amount)
	if machine.updateInventory() then
		slot = slot - 1
		if world.containerTakeNumItemsAt( entity.id(), slot, amount ) then
			return true
		else
			return false
		end
	end
	
	return false
end

-- Make entity produce an item
function machine.produceItem(itemName, amount)
	if world.containerItemsCanFit( entity.id(), { name = itemName, count = amount, data = {} } ) then
		world.containerAddItems( entity.id(), { name = itemName, count = amount, data = {} } )
		return true
	end
	return false
end

-- Consume fuelItem to refuel
function machine.refuel(slot, amount)
	machine.updateInventory()
	
	if amount == nil then
		amount = 1
	end
	
	if slot == nil then
		slot = 1
	end
	
	if inventory[slot] == nil then return false end
	
	if machine.updateInventory() then
		for k, v in pairs(fuelList) do
			if inventory[slot].name == k then
				if inventory[slot].count >= amount then
					if machine.consumeItem( slot, amount ) then
						storage.fuel = storage.fuel + v
						return true
					end
				end
			end
		end
	end
	
	return false
end

-- Increase the machines fuellevel without consuming an item
function machine.increaseFuel(amount)
	storage.fuel = storage.fuel + amount
end

-- Decrease the fuelLevel
function machine.consumeFuel(amount, skip)
	if storage.fuel >= amount then
		storage.fuel = storage.fuel - amount
		return true
	elseif skip then
		storage.fuel = 0
		return true
	end
	
	return false
end

function machine.setFuel(amount)
	storage.fuel = amount
end

function machine.getFuelLevel()
	if storage.fuel == nil then storage.fuel = 0 end
	return storage.fuel
end
