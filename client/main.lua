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
                    rentid = k,
                    type = "client",
                    event = "qb-rental:client:startrent",
                    icon = v.icon,
                    label = v.title,
                    vehicledata = Config.VehicleList[v.vehiclelist],
                    carspawn = v.carspawn
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
        header = Lang:t('menu.return_header'),
        txt = Lang:t('menu.return_text'),
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
                    rentid = data.rentid,
                    vehdata = v,
                    carspawn = data.carspawn
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

RegisterNetEvent('qb-rental:client:startspotloop', function(rentid, carspot, carspawn, netId)
    local inzone = true
    while true do
        Wait(300)
        local vehcoord = GetEntityCoords(NetworkGetEntityFromNetworkId(netId))
        local distance = GetDistanceBetweenCoords(vehcoord, carspawn)
        if distance >= 30 and inzone == true then
            inzone = false
            TriggerServerEvent("qb-rental:server:freespot", rentid, carspot)
            Wait(100)
            break
        end
    end
end)

function GetDistanceBetweenCoords(coord1_in, coord2_in)
    local x1 = coord1_in.x
    local x2 = coord2_in.x
    local y1 = coord1_in.y
    local y2 = coord2_in.y
    local z1 = coord1_in.z
    local z2 = coord2_in.z
    local distance = math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
    return distance
end