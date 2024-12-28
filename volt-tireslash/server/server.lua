RegisterServerEvent('volt-tireslash:sync')
AddEventHandler('volt-tireslash:sync', function(id, tireIndex)
	TriggerClientEvent('volt-tireslash:sync', id, tireIndex)
end)