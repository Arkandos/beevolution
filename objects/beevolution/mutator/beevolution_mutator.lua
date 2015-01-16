local breedMultiplier = 2
local fuelCost = 20
local radioactiveList = { uraniumrod = 60, plutoniumrod = 90 }

function init(virtual)
	if virtual then return end
	
	if storage.fuel == nil then storage.fuel = 0 end
	
end

local function updateInventory()
	inventory = world.containerItems(entity.id())
	if inventory == nil then return false else return true end
end

function addRadiation( amount )
	storage.fuel = storage.fuel + amount
end

function getRadiation()
	return storage.fuel
end

function main()
	updateInventory()
	
	if storage.fuel >= fuelCost then
		entity.setAnimationState("mutatorState", "active")
	else
		entity.setAnimationState("mutatorState", "idle")
	end
	
	if inventory[1] == nil or inventory[2] == nil then return end
	
	if breed.getType(inventory[1].name) == "princess" and breed.getType(inventory[2].name) == "drone" then
		if breed.getSpecies(inventory[1].name) == breed.getSpecies(inventory[2].name) then return end
	
		if storage.fuel >= fuelCost then
			machine.consumeFuel(fuelCost)
			breed.breed(inventory[1].name, inventory[2].name, breedMultiplier)
		else
			for k, v in pairs(radioactiveList) do
				if inventory[3].name == k then
					if machine.consumeItem(3, 1) then
						machine.increaseFuel(v)
					end
				end
			end
		end
	end
end

