Config = {}

Config.TargetSystem = 'qtarget' -- Choices confirmed working are currently 'qtarget' and 'qb-target'

Config.allowedWeapons = {
    `WEAPON_KNIFE`,
    `WEAPON_BOTTLE`,
    `WEAPON_DAGGER`,
    `WEAPON_HATCHET`,
    `WEAPON_MACHETE`,
    `WEAPON_SWITCHBLADE`
}

-- Updated notification system using ox_lib
RegisterNetEvent('volt-tireslash:notify')
AddEventHandler('volt-tireslash:notify', function(message, type)
    lib.notify({
        title = 'Notification',
        description = message,
        type = type or 'inform', -- Default notification type is 'inform'
        position = 'top-right' -- You can change the position if needed
    })
end)

Language = {
    ['no_weapon'] = 'You need to be holding something sharp to do this!',
    ['car_slashed'] = 'Someone slashed your tire!',
    ['already_slashed'] = 'This tire has already been flattened!'
}
