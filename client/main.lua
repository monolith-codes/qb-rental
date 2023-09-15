local QBCore = exports['qb-core']:GetCoreObject()
local SpawnVehicle = false
local RentedCars = {}

CreateThread(function()
    Wait(1000)
    for k,v in pairs(Config.Rentals) do
        RequestModel(GetHashKey(v.pedhash))
        while not HasModelLoaded(GetHashKey(v.pedhash)) do
            Wait(1)
        end
        created_ped = CreatePed(5, GetHashKey(v.pedhash) , v.spawnpoint.x, v.spawnpoint.y, (v.spawnpoint.z-1), v.spawnpoint.w, false, true)
        FreezeEntityPosition(created_ped, true)
        SetEntityInvincible(created_ped, true)
        SetBlockingOfNonTemporaryEvents(created_ped, true)
        TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
        exports['qb-target']:AddTargetEntity(created_ped, {
            options = {
                {
                    type = "client",
                    event = "qb-rental:client:startrent",
                    icon = v.icon,
                    label = v.title,
                    vehicledata = Config.VehicleList[v.vehiclelist],
                },
            },
            distance = 3.0
        })
    end
end)

RegisterNetEvent('qb-rental:client:startrent', function(data)
    local sendmenu =  {}
    local menuheader = {
        header = data.label,
        isMenuHeader = true,
    }
    local menureturn =  {
        id = 1,
        header = "Gebe dein Fahrzeug zurück ",
        txt = "Gebe dein Fahrzeug zurück und erhalte die Kaution wieder.",
        params = {
            event = "qb-rental:client:startreturnvehicle",
        }
    }
    table.insert(sendmenu, menuheader)
    table.insert(sendmenu, menureturn)
    local idi = 2
    for k,v in pairs(data.vehicledata) do
        local menuentry =  {
            id = idi,
            header = v.name,
            txt = v.price.." $",
            params = {
                event = "qb-rental:client:rentcar",
                args = {
                    vehdata = v,
                }
            }
        }
        table.insert(sendmenu, menuentry)
        idi = idi+1
        Wait(1)
    end
    Wait(1)
    exports['qb-menu']:openMenu(sendmenu)
end)

RegisterNetEvent('qb-rental:client:rentcar', function(data)
    TriggerServerEvent('qb-rental:server:rentcar', data)
end)

RegisterNetEvent('qb-rental:client:setupvehicle', function(vehicle_sv_id)
    local veh = NetworkGetEntityFromNetworkId(vehicle_sv_id)
    table.insert(RentedCars, vehicle_sv_id)
    exports['LegacyFuel']:SetFuel(veh, 100)
end)

RegisterNetEvent('qb-rental:client:startreturnvehicle', function()
    TriggerServerEvent("qb-rental:server:startreturnvehicle", PlayerPedId())
end)
