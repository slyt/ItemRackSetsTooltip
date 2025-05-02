-- Extract just the itemID from the colon-delimited string
local function GetItemIDFromString(inputString)
    return tonumber(string.match(inputString, "^(%d+)"))
end

-- Return a list of all set names in ItemRackUser
local function GetSets()
    local sets = {}
    if ItemRackUser and ItemRackUser.Sets then
        for setName, _ in pairs(ItemRackUser.Sets) do
            table.insert(sets, setName)
        end
    end
    return sets
end

-- Search all sets to find which ones include the given itemID
local function SearchSets(itemID)
    local foundSets = {}
    if not ItemRackUser or not ItemRackUser.Sets then return foundSets end

    for setName, setData in pairs(ItemRackUser.Sets) do
        local equipTable = setData["equip"]
        if equipTable then
            for _, itemString in pairs(equipTable) do
                local id = GetItemIDFromString(itemString)
                if id == itemID then
                    table.insert(foundSets, setName)
                    break -- avoid duplicates
                end
            end
        end
    end
    return foundSets
end

-- Hook into tooltip to display set info
local function OnTooltipSetItem(tooltip)
    local name, link = tooltip:GetItem()
    if not link then return end

    local itemID = tonumber(string.match(link, "item:(%d+):"))
    if not itemID then return end

    local sets = SearchSets(itemID)
    if #sets > 0 then
        tooltip:AddLine("|cffffcc00ItemRack Sets:|r " .. table.concat(sets, ", "))
        tooltip:Show()
    end
end

-- Delay hook until PLAYER_ENTERING_WORLD so ItemRackUser is available
local function InitTooltipHook()
    GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
end

local EventFrame = CreateFrame("frame", "ItemRackTooltipInitFrame")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:SetScript("OnEvent", function(self, event)
    C_Timer.After(1, InitTooltipHook)
end)
