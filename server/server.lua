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

AddEventHandler('esx:playerLoaded', function(playerId)

    local xPlayer = ESX.GetPlayerFromId(playerId)

    MySQL.Async.fetchScalar("SELECT armor FROM users WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.getIdentifier()
        }, function(data)
        if (data ~= nil) then

            ESX.SetTimeout(15000, function()
		
                TriggerClientEvent("alpha:updateArmor", playerId, data)
            
            end)

        end
    end)

end)

RegisterServerEvent('alpha:armorDB')
AddEventHandler('alpha:armorDB', function(updateArmor)

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.execute("UPDATE users SET armor = @armor WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.getIdentifier(),
        ['@armor'] = tonumber(updateArmor)
    })

end)
