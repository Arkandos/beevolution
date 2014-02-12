-- Utility Functions

function compareTables(firstTable, secondTable)
    if (next(firstTable) == nil) and (next(secondTable) == nil) then
        return true
    end
    for key,value in pairs(firstTable) do
        if firstTable[key] ~= secondTable[key] then
            return false
        end
    end
    for key,value in pairs(secondTable) do
        if firstTable[key] ~= secondTable[key] then
            return false
        end
    end
    return true
end

-- Definitions

storage = {}
storageModes = {"none", "input", "output", "both"}

-- API functions

-- Init storage
function storage.init(args)

	if storage.items == nil then
		storage.items = args.content or  0
	end

	storage.mode = args.mode
	
	if storage.mode == "input" or storage.mode == "both" then
		storage.in = true
	elseif storage.mode == "output" or storage.mode == "both" then
		storage.out = true
	elseif storage.mode == "none" then
		storage.in = false
		storage.out = false
	end
	
	if args.ondeath == "drop" then
		storage.onDeath = "drop"
	else
		storage.onDeath = "none"
	end

	if storage.in == nil then storage.in = false end
	if storage.out == nil then storage.out = false end
	storage.capacity = math.min(999, args.capacity or 1)
	storage.isMerge = args.merge
	storage.dropPos = args.dropPos or entity.position()
	
end

-- Is extracting items allowed?
function storage.isOutput()
	return storage.out
end

-- Is inputting items allowed?
function storage.isInput()
	return storage.in
end

-- Is this storage merging its stacks?
function storage.isMerging()
	return storage.isMerge
end

-- Is storage full?
function storage.isFull()
	return storage.getCount() >= storage.getCapacity()
end

-- Get capacity
function storage.getCapacity()
	return storage.capacity
end

-- Get current storage
function storage.getCount()
	local count = 0
	for c in storage.getIterator() do count = count + 1 end
	return count
end

-- Get the data in (index)
function storage.analyze(index)
	return storage.items[index]
end

-- Iterators for the storage 
function storage.getIterator()
	return pairs(storage.items)
end

-- Retrieve an item from the storage
function storage.takeItem(index, count)
	local item = storage.items[index]
	if count == nil or item.count <= count then
		storage.items[index] = nil
	else
		storage.items[index].count = item.count - count
	end
end
