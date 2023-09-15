local QBCore = exports['qb-core']:GetCoreObject()
local RentedCars = {}

RegisterServerEvent('qb-rental:server:rentcar')
AddEventHandler('qb-rental:server:rentcar', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.money["cash"] >= data.vehdata.price then
        if Player.Functions.RemoveMoney('cash', data.vehdata.price) then
            local veh = QBCore.Functions.SpawnVehicle(src, data.vehdata.model, vector4(-338.1298, -1944.6716, 21.6034, 338.6489), true)
            Wait(100) 
            SetEntityHeading(veh, 239.1814)
            Wait(100)
            local netId = NetworkGetNetworkIdFromEntity(veh)
            local rentedcar = {}
            rentedcar.veh = veh
            rentedcar.netid = netId
            rentedcar.owner = src
            rentedcar.returnprice = data.vehdata.returnprice
            if RentedCars[src] == nil then
                RentedCars[src] = {}
            end
            TriggerClientEvent("vehiclekeys:client:SetOwner", src, GetVehicleNumberPlateText(veh))
            table.insert(RentedCars[src], rentedcar)
            TriggerClientEvent('qb-rental:client:setupvehicle', src, netId)
            Wait(100)
            local retmsg = "vehicle rent for "..data.vehdata.price.."$, return it to get "..data.vehdata.returnprice.."$ back"
            TriggerClientEvent('QBCore:Notify', src, retmsg, "success")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "you dont have enough money", "error")
    end
end)

RegisterServerEvent('qb-rental:server:startreturnvehicle')
AddEventHandler('qb-rental:server:startreturnvehicle', function(ped)
    local src = source
    local coords = GetEntityCoords(GetPlayerPed(src), false)
    if RentedCars[src] ~= nil then
        local returned = 0
        local returendprice = 0
        for k,v in pairs(RentedCars[src]) do 
            local returnvehcoord = GetEntityCoords(v.veh, false)
            local distance = GetDistanceBetweenCoords(coords, returnvehcoord)
            if distance <= 20 then
                ReturnVehicle(src, v.veh, k, v.returnprice)
                returned = returned + 1
                returendprice = returendprice + v.returnprice
            end
            Wait(5)
        end
        local retmsg = returned.." vehicles returned for "..returendprice.."$"
        TriggerClientEvent('QBCore:Notify', src, retmsg, "success")
    end
end)

function ReturnVehicle(src, veh, index, returnprice)
    DeleteEntity(veh)
    local Player = QBCore.Functions.GetPlayer(src)

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