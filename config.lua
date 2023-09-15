Config = {}

Config.Rentals = {
    [0] = {
        id = "normal_01",
        pedhash = "a_m_y_business_03",
        title = "Normal Vehicle Rental",
        icon = "fas fa-box-circle-check",
        spawnpoint = vector4(),
        carspawns = {
            [1] = vector4(),
            [2] = vector4(),
            [3] = vector4(),
        },
        vehiclelist = "vehlist01"
    },
    [1] = {
        id = "normal_02",
        pedhash = "a_m_y_business_03",
        title = "Normal Vehicle Rental",
        icon = "fas fa-box-circle-check",
        spawnpoint = vector4(),
        carspawns = {
            [1] = vector4(),
            [2] = vector4(),
            [3] = vector4(),
        },
        vehiclelist = "vehlist02"
    }
}

Config.VehicleList = {
    ["vehlist01"] = {
        [0] = {
            name = "Car 1",
            model = "car2",
            price = 1000,
            returnprice = 200,
        },
        [1] = {
            name = "Car 2",
            model = "car1",
            price = 550,
            returnprice = 100,
        },
    },
    ["vehlist02"] = {
        [0] = {
            name = "Car 3",
            model = "car3",
            price = 1000,
            returnprice = 200,
        },
        [1] = {
            name = "Car 4",
            model = "car4",
            price = 550,
            returnprice = 100,
        },
    }
}