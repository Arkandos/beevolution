function init(virtual)
	storage.animState = "idle"
	if vitual then return end
end

function main()
	beeMachine.main(true, { productionMultiplier = 1.25, breedMultiplier = 0.5, fuelConsumption = 1, fuelSlot = 3 })
	
	local inventory = world.containerItems(entity.id())
	
	if inventory[1] ~= nil then
		if breed.getType(inventory[1].name) == "queen" and storage.fuel > 0 then
			if storage.animState == "idle" then
				entity.setAnimationState("apiaryState", "active")
				storage.animState = "active"
			end
		else
			entity.setAnimationState("apiaryState", "idle")
			storage.animState = "idle"
		end
	else
		entity.setAnimationState("apiaryState", "idle")
		storage.animState = "idle"
	end
end