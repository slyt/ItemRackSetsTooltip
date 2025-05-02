local function OnTooltipSetItem(tooltip)
    local name, link = tooltip:GetItem()
    if link then
        local itemName, itemLink, itemRarity, itemLevel, _, itemType, itemSubType, _, itemEquipLoc, itemIcon, itemSellPrice = GetItemInfo(link)
        print("Hovered Item Info:")
        print("Name:", itemName)
        print("Item Level:", itemLevel)
        print("Type:", itemType, "-", itemSubType)
        print("Equip Location:", _G[itemEquipLoc] or itemEquipLoc)
        print("Sell Price:", GetCoinText(itemSellPrice))

        -- Add item level to tooltip
        if itemLevel then
            tooltip:AddLine("|cff00ff00Item Level: " .. itemLevel .. "|r") -- green text
            tooltip:Show()
        end
    end
end

GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
