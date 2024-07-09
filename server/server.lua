RegisterNetEvent("menuboss:config")
AddEventHandler("menuboss:config", function()
    local _src = source
    TriggerClientEvent("settable:config", _src, bossMenu)
end)