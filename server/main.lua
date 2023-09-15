local QBCore = exports['qb-core']:GetCoreObject()
local RentedCars = {}
local VehicleSpots = {}

RegisterServerEvent('qb-rental:server:rentcar')
AddEventHandler('qb-rental:server:rentcar', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.money["cash"] >= data.vehdata.price then
        GetVehicleSpot(src, data)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.not_enough_money'), "error")
    end
end)

RegisterServerEvent('qb-rental:server:startreturnvehicle')
AddEventHandler('qb-rental:server:startreturnvehicle', function(ped)
    local src = source
    local coords = GetEntityCoords(GetPlayerPed(src), false)
    if RentedCars[src] ~= nil then
        local returned = 0
        local returendprice = 0
        local novehreturned = true
        for k,v in pairs(RentedCars[src]) do 
            local returnvehcoord = GetEntityCoords(v.veh, false)
            local distance = GetDistanceBetweenCoords(coords, returnvehcoord)
            if distance <= 20 then
                ReturnVehicle(src, v.veh, k, v.returnprice)
                returned = returned + 1
                returendprice = returendprice + v.returnprice
                novehreturned = false
            end
            Wait(5)
        end
        local retmsg = returned..Lang:t('success.return_04')..returendprice.."$"
        if novehreturned == true then
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.not_vehicle_nearby'), "error")
        else 
            TriggerClientEvent('QBCore:Notify', src, retmsg, "success")
        end
    end
end)

RegisterServerEvent('qb-rental:server:freespot')
AddEventHandler('qb-rental:server:freespot', function(id1, id2)
   VehicleSpots[id1][id2].used = false
end)


function ReturnVehicle(src, veh, index, returnprice)
    DeleteEntity(veh)
    if Player.Functions.AddMoney('cash', returnprice) then
        return 1
    end
    return 0
end

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

function GetVehicleSpot(src, data)
    local Player = QBCore.Functions.GetPlayer(src)
    local foundspot = false
    if VehicleSpots[data.rentid] == nil then
        VehicleSpots[data.rentid] = {}
        for k,v in pairs(Config.Rentals[data.rentid].carspawns) do
            VehicleSpots[data.rentid][k] = {}           
            VehicleSpots[data.rentid][k].id = k
            VehicleSpots[data.rentid][k].coord = v
            VehicleSpots[data.rentid][k].used = false
            Wait(1)
        end
        Wait(1)
        if Player.Functions.RemoveMoney('cash', data.vehdata.price) then
            foundspot = true
            VehicleSpots[data.rentid][1].used = true
            RentSpawnCar(src, data.vehdata.model, Config.Rentals[data.rentid].carspawns[1], data.vehdata.price, data.vehdata.returnprice, data.rentid, 1)   
        end
    else
        local spot = 0
        for k,v in pairs(VehicleSpots[data.rentid]) do
            Wait(1)
            if v.used == false then
                foundspot = true
                spot = v.id
                break
            end
        end
        if spot ~= 0 and foundspot == true then
            if Player.Functions.RemoveMoney('cash', data.vehdata.price) then
                VehicleSpots[data.rentid][spot].used = true
                RentSpawnCar(src, data.vehdata.model, Config.Rentals[data.rentid].carspawns[spot], data.vehdata.price, data.vehdata.returnprice, data.rentid, spot)
            end
        end
    end
    if foundspot == false then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.nospotfound'), "error")
    end
end

function RentSpawnCar(src, model, carspawn, price, returnprice, rentid, carspot)
    local veh = QBCore.Functions.SpawnVehicle(src, model, carspawn, true)
    Wait(100) 
    SetEntityHeading(veh, carspawn.w)
    Wait(100)
    local netId = NetworkGetNetworkIdFromEntity(veh)
    local rentedcar = {}
    rentedcar.veh = veh
    rentedcar.netid = netId
    rentedcar.owner = src
    rentedcar.returnprice = returnprice
    if RentedCars[src] == nil then
        RentedCars[src] = {}
    end
    TriggerClientEvent("vehiclekeys:client:SetOwner", src, GetVehicleNumberPlateText(veh))
    table.insert(RentedCars[src], rentedcar)
    TriggerClientEvent('qb-rental:client:setupvehicle', src, netId)
    Wait(100)
    local retmsg = ""..Lang:t('success.return_01')..price..Lang:t('success.return_02')..returnprice..Lang:t('success.return_03')..""
    TriggerClientEvent('QBCore:Notify', src, retmsg, "success")
    TriggerClientEvent("qb-rental:client:startspotloop", src, rentid, carspot, carspawn, netId)
end