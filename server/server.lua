RegisterNetEvent("menuboss:config")
AddEventHandler("menuboss:config", function()
    local _src = source
    TriggerClientEvent("settable:config", _src, bossMenu)
end)



local cacheSociety = {}

MySQL.ready(function() 
    MySQL.Async.fetchAll("SELECT account_name, money FROM addon_account_data", function(result)
        for _,v in pairs(result) do 
            table.insert(cacheSociety, v)
        end
    end)
end)


RegisterNetEvent("sendInfoCache")
AddEventHandler("sendInfoCache", function(valeur)
    local _src = source
    local infoEnteprise = {}
    for _,v in pairs(cacheSociety) do 
        if valeur.societyName == v.account_name then 
            table.insert(infoEnteprise, v)
            TriggerClientEvent("sendInfoCache", _src, infoEnteprise)
        end
    end
end)


RegisterNetEvent("actionSocietyMoney")
AddEventHandler("actionSocietyMoney", function(index, societyName, money)
    for _,v in pairs(cacheSociety) do 
        if societyName == v.account_name then 
            if index == 1 then 
                v.money = v.money - money
            elseif index == 2 then 
                v.money = v.money + money
            end
        end
    end
end)