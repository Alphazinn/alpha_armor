ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("armor", function(source)

    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("alpha:armor", source)

end)

RegisterServerEvent("alpha:giveArmor")
AddEventHandler("alpha:giveArmor", function()

    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("armor", 1)

end)

RegisterServerEvent("alpha:removeArmor")
AddEventHandler("alpha:removeArmor", function()

    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem("armor", 1)

end)