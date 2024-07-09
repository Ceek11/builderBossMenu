ESX = exports["es_extended"]:getSharedObject()

bossMenu = {}
RegisterNetEvent("settable:config")
AddEventHandler("settable:config", function(menuboss)
    bossMenu = menuboss
end)

CreateThread(function()
    TriggerServerEvent("menuboss:config")
    while true do 
        local interval = 2000
        local posPlayer = GetEntityCoords(PlayerPedId())
        for _,v in pairs(bossMenu) do 
            print(json.encode(v))
            local dest = v.point
            local dist = Vdist2(dest.x, dest.y, dest.z, posPlayer)
            if dist <= v.distMarket then 
                interval = 0
                DrawMarker(21, dest.x, dest.y, dest.z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 0, 0, 255, false, false, false, false, false, false, false)
                if dist <= v.distHelpNotif then 
                    ESX.ShowHelpNotification(v.textHelp)
                    if IsControlJustPressed(1, 51) then 
                        openMenuBoss()
                    end
                end
            end
        end
        Wait(interval)
    end
end)