local infoEntreprise
local infoEntrepriseLoad = false
local moneySociety
RegisterNetEvent("sendInfoCache")
AddEventHandler("sendInfoCache", function(cache)
    infoEntreprise = cache
    CreateThread(function()
        Wait(500)
        infoEntrepriseLoad = true
    end)
end)

local index = 1
local indexActionMoney = 1
local IndexActionJoueur = 1
local openBoss = false 
menuBoss = RageUI.CreateMenu("Boss", " ")
menuGestionEntreprise = RageUI.CreateSubMenu(menuBoss, " ", " ")
menuGestionEmploye = RageUI.CreateSubMenu(menuBoss, " ", " ")
menuBoss.Closed = function()
    openBoss = false 
end



function openMenuBoss(valeur)
    if openBoss then 
        openBoss = false 
        RageUI.Visible(menuBoss, false)
        return
    else 
        TriggerServerEvent("sendInfoCache", valeur)
        openBoss = true
        RageUI.Visible(menuBoss, true)
        CreateThread(function()
            while openBoss do 
                RageUI.IsVisible(menuBoss, function()
                    if infoEntrepriseLoad then 
                        for k, v in pairs(infoEntreprise) do 
                            RageUI.Separator(("Argent entreprise : ~g~%s$~s~"):format(v.money))
                        end
                        RageUI.Line()
                        RageUI.List("Action money", {"Retirer", "Déposer"}, indexActionMoney, nil, {}, true, {
                            onListChange = function(index, items)
                                indexActionMoney = index
                            end,
                            onSelected = function()
                                local input = lib.inputDialog("Choisire le montant", {{type = 'number', label = "Choisire le montant", icon = 'hashtag'}})
                                if input then
                                    TriggerServerEvent("actionSocietyMoney", indexActionMoney, valeur.societyName, input[1])
                                end
                            end
                        })
                        RageUI.Line()
                        RageUI.Button("Gestion Entreprise", nil, {}, true, {}, menuGestionEntreprise)
                    else
                        RageUI.Separator("")
                        RageUI.Separator("En attente des données")
                        RageUI.Separator("")
                    end
                end)
                RageUI.IsVisible(menuGestionEntreprise, function()
                    RageUI.Button("Gestion employées", nil, {}, true, {}, menuGestionEmploye)
                    RageUI.Button("Gestion sotck", nil, {}, true, {})
                    RageUI.Button("Gestion permission", nil, {}, true, {})
                    RageUI.Button("Gestion Farm", nil, {}, true, {})
                    RageUI.Button("Gestion historique", nil, {}, true, {})
                end)
                RageUI.IsVisible(menuGestionEmploye, function()
                    RageUI.List("Action joueur", {"Recruter", "Virer"}, IndexActionJoueur, nil, {}, true, {
                        onListeChange = function(index, items) 
                            IndexActionJoueur = index
                        end
                    })
                    RageUI.Button("Gestion Salaire", nil, {}, true, {})
                    RageUI.Button("Gestion Farm", nil, {}, true, {})
                    RageUI.Button("Classement employee", nil, {}, true, {})
                    RageUI.Line()
                    RageUI.Button("Mathieu | Chef", nil, {}, true, {})
                end)
                Wait(0)
            end
        end)
    end
end



-- Gestion employées (Top melleure employée - Changer les grades et virer / recruter)
-- Gestion Salaire (Donner un bonus, changer les salaires)
-- Gestion stock (Pouvoir ajouter des stock de n'importe quoi facilement)
-- Gestion permission (Crée des grades et le donner des permissions)
-- Gestion Farm Voir combien les gens on farme (pouvoir les reset et donner un bonus)
-- Gestion historique (Voir l'historique de tout les factures de jours et de l'entreprise)