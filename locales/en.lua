local Translations = {
    error = {
        not_enough_money = 'You dont have enough money',
        not_vehicle_nearby = 'No vehicle nearby',
    },
    success = {
        return_01 = 'Vehicle rent for ',
        return_02 = '$, return it to get ',
        return_03 = '$ back',
        return_04 = ' vehicles returned for ',
    },
    menu = {
        return_header = 'Return vehicle',
        return_text = 'Return all your vehicles and get your deposit back',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})