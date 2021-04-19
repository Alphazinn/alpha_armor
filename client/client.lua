ESX = nil
local armorTaken = false

Citizen.CreateThread(function()
    
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(10000)

end)

RegisterNetEvent("alpha:armor")
AddEventHandler("alpha:armor", function(source)

	local ped = PlayerPedId()
    local pedArmor = GetPedArmour(ped)

	if pedArmor >= 100 then

		exports['mythic_notify']:DoHudText('inform', 'Zaten Bir Çelik Yelek Giyiyorsun!', { ['background-color'] = '#335a6c', ['color'] = '#ffffff' })

	elseif pedArmor < 100 then

		TriggerEvent("mythic_progbar:client:progress", {
			name = "unique_action_name",
			duration = 8000,
			label = "Çelik Yelek Giyiyorsun...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "missmic4",
				anim = "michael_tux_fidget",
			}
		}, function(status)
			if not status then

				AddArmourToPed(ped, 100 - pedArmor)
				TriggerServerEvent("alpha:removeArmor")
				exports['mythic_notify']:DoHudText('success', 'Çelik Yelek Giydin!', { ['background-color'] = '#599958', ['color'] = '#ffffff' })

			end
		end)
		
	end
end)

RegisterNetEvent("alpha:updateArmor")
AddEventHandler("alpha:updateArmor", function(armor)

	ESX.SetTimeout(15000, function()
		
		SetPedArmour(PlayerPedId(), tonumber(armor))
		armorTaken = true
		
	end)

end)

Citizen.CreateThread(function()

	while true do

		Citizen.Wait(2500)
		if armorTaken == true then

			TriggerServerEvent("alpha:armorDB", GetPedArmour(PlayerPedId()))
			Citizen.Wait(10000)

		end
		
	end

end)
