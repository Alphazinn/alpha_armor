ESX = nil

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

		FreezeEntityPosition(ped, true)

		TriggerEvent("mythic_progbar:client:progress", {
			name = "unique_action_name",
			duration = 8000,
			label = "Çelik Yelek Giyiyorsun...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = false,
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
				FreezeEntityPosition(ped, false)

			elseif status then

				FreezeEntityPosition(ped, false)

			end
		end)
		
	end
end)