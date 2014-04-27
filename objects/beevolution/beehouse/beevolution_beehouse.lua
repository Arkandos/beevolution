function init(virtual)
	
	if vitual then return end
	
	-- Check if the beehouse is above ground
	if not isAboveGround() then
		return { "ShowPopup", { message = "The little bees need a clear line of sight of the sky!"} }
	end
	
end


function main()
	beeMachine.main(true, {productionMultiplier = 1, breedMultiplier = 1})
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