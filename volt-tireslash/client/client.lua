CreateThread(function()
    local bones = {'wheel_lf', 'wheel_rf', 'wheel_lm1', 'wheel_rm1', 'wheel_lm2', 'wheel_rm2', 'wheel_lm3', 'wheel_rm3', 'wheel_lr', 'wheel_rr'}
    exports[Config.TargetSystem]:AddTargetBone(bones, {
        options = {
            {
                event = 'volt-tireslash:slash',
                icon = 'fas fa-info',
                label = 'Slash Tire',
                num = 1
            },
        },
        distance = 1
    })
end)

RegisterNetEvent('volt-tireslash:slash', function()
    local vehicle = GetClosestVehicleToPlayer()
    if vehicle ~= 0 then
        if CanUseWeapon(Config.allowedWeapons) then
            local closestTire = GetClosestVehicleTire(vehicle)
            if closestTire ~= nil then
                if IsVehicleTyreBurst(vehicle, closestTire.tireIndex, 0) == false then
                    local animDict = 'melee@knife@streamed_core_fps'
                    local animName = 'ground_attack_on_spot'
                    loadDict('melee@knife@streamed_core_fps')
                    local animDuration = GetAnimDuration(animDict, animName)
                    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, animDuration, 15, 1.0, 0, 0, 0)
                    Wait((animDuration / 2) * 1000)
                    local driverId = GetDriverOfVehicle(vehicle)
                    local driverServId = GetPlayerServerId(driverId)
                    if driverServId == 0 then
                        SetEntityAsMissionEntity(vehicle, true, true)
                        SetVehicleTyreBurst(vehicle, closestTire.tireIndex, 0, 100.0)
                        SetEntityAsNoLongerNeeded(vehicle)
                    else
                        TriggerServerEvent('volt-tireslash:sync', driverServId, closestTire.tireIndex)
                    end
                    Wait((animDuration / 2) * 1000)
                    ClearPedTasks(PlayerPedId())
                    RemoveAnimDict(animDict)
                else
                    lib.notify({
                        title = 'Notification',
                        description = Language['already_slashed'],
                        type = 'error'
                    })
                end
            end
        else
            lib.notify({
                title = 'Notification',
                description = Language['no_weapon'],
                type = 'error'
            })
        end
    end
end)

RegisterNetEvent('volt-tireslash:sync')
AddEventHandler('volt-tireslash:sync', function(tireIndex)
    lib.notify({
        title = 'Notification',
        description = Language['car_slashed'],
        type = 'success'
    })
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    SetVehicleTyreBurst(vehicle, tireIndex, 0, 100.0)
end)
