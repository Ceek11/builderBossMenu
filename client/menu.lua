
local index = 1
local indexChange = 1
local openBoss = false 
menuBoss = RageUI.CreateMenu("Boss", " ")
menuBoss.Closed = function()
    openBoss = false 
end

function openMenuBoss()
    if openBoss then 
        openBoss = false 
        RageUI.Visible(menuBoss, false)
        return
    else 
        openBoss = true
        RageUI.Visible(menuBoss, true)
        CreateThread(function()
            while openBoss do 
                RageUI.IsVisible(menuBoss, function()
                    RageUI.Separator("Argent entreprise : ")
                    RageUI.List("Action money", {"retirer", "déposer"}, indexChange, nil, {}, true, {
                        onListChange = function(index, items)
                            indexChange = index
                        end
                    })
                    RageUI.Button("Gestion employées", nil, {}, true, {})
                    RageUI.Button("Gestion Salaire", nil, {}, true, {})
                    RageUI.Button("Gestion sotck", nil, {}, true, {})
                    RageUI.Button("Gestion permission", nil, {}, true, {})
                    RageUI.Button("Gestion Farm", nil, {}, true, {})
                    RageUI.Button("Gestion historique", nil, {}, true, {})
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