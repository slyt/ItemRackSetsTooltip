print("Hello, Azeroth!")

local function PrintSets()
    local set = ItemRackUser.Sets["DPS"]['equip']
    if not set then
        print("No DPS set found.")
        return
    end

    print("Contents of 'DPS' set:")
    for k, v in pairs(set) do
        local itemID = string.match(v, "^(%d+)")
        if itemID then
            print("Item ID:", itemID)
        else
            print("Could not parse item ID from:", v)
        end
    end
end

local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

EventFrame:SetScript("OnEvent", function(self, event, ...)
	if(event == "PLAYER_ENTERING_WORLD") then
		C_Timer.After(1, PrintSets)
	end
end)


