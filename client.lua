local QBCore = nil
local ESX = nil

if Config.Framework == "qbcore" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports['es_extended']:getSharedObject()
else
    print("Invalid framework configuration!")
end


function SendNotify(message)
    if Config.NotifySystem == "qbcore" then
        QBCore.Functions.Notify(message)
    elseif Config.NotifySystem == "esx" then
        ESX.ShowNotification(message)
    elseif Config.NotifySystem == "other" then
        print(message) 
    else
        print("Invalid notify system configuration!")
    end
end


function HasGPS()
    local hasGPS = false

    if Config.InventorySystem == "ox_inventory" then
        if exports.ox_inventory:Search('count', Config.GPSEquipment) > 0 then
            hasGPS = true
        end
    elseif Config.InventorySystem == "qbcore" then
        local PlayerData = QBCore.Functions.GetPlayerData()
        for k, v in pairs(PlayerData.items) do
            if v.name == Config.GPSEquipment and v.amount > 0 then
                hasGPS = true
                break
            end
        end
    elseif Config.InventorySystem == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        local item = xPlayer.getInventoryItem(Config.GPSEquipment)
        if item and item.count > 0 then
            hasGPS = true
        end
    elseif Config.InventorySystem == "other_inventory" then
        -- Example:
        -- local otherInventory = exports['other_inventory']:GetInventory()
        -- if otherInventory:HasItem(Config.GPSEquipment) then
        --     hasGPS = true
        -- end
    else
        print("Invalid inventory system configuration!")
    end

    return hasGPS
end

CreateThread(function()
    while true do
        Wait(5000) -- Her 5 saniye kontrol et

        if Config.MinimapEnabled then
            DisplayRadar(true)  -- Minimap her zaman açık
        else
            DisplayRadar(false) -- Minimap kapalı
        end

        if not HasGPS() then
            SetRadarBigmapEnabled(true, false)
            SendNotify(Config.Messages.NoGPS)
        else
            SetRadarBigmapEnabled(false, false)
            SendNotify(Config.Messages.GPSActivated)
        end
    end
end)
