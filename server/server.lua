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
    MySQL.Async.fetchAll("SELECT salary, job_name, label, grade FROM job_grades", function(result)
        for _,v in pairs(result) do 
            table.insert(cacheSociety, v)
        end 
    end)
    MySQL.Async.fetchAll("SELECT job, job_grade, lastname, firstname, label FROM users INNER JOIN job_grades ON job_grades.grade = users.job_grade AND users.job = job_grades.job_name", {}, function(result)
        for _, v in pairs(result) do
            table.insert(cacheSociety, v)
        end
    end)
end)    


RegisterNetEvent("sendInfoCache")
AddEventHandler("sendInfoCache", function(valeur)
    local _src = source
    local infoEnteprise = {}
    for _,v in pairs(cacheSociety) do 
        table.insert(infoEnteprise, v)
        TriggerClientEvent("sendInfoCache", _src, infoEnteprise)
    end
end)


RegisterNetEvent("actionSocietyMoney")
AddEventHandler("actionSocietyMoney", function(index, societyName, money)
    for _,v in pairs(cacheSociety) do 
        if societyName == v.account_name then
            if index == 1 and v.money >= money and money >= 0 then 
                    v.money = v.money - money
            elseif index == 2 and money >= v.money and money >= 0 then 
                v.money = v.money + money
            end
        end
    end
end)


RegisterNetEvent("changeSalary")
AddEventHandler("changeSalary", function(name, grade, montant)
    for _,v in pairs(cacheSociety) do
        if name == v.job_name and grade == v.grade then  
            v.salary = montant
        end
    end
end)