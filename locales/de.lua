local Translations = {
    error = {
        not_enough_money = 'Du hast nicht genug Bargeld',
        not_vehicle_nearby = 'Kein Fahrzeug in der Nähe',
    },
    success = {
        return_01 = 'Fahrzeug gemietet für ',
        return_02 = '$, gebe es zurück für ',
        return_03 = '$ Kaution',
        return_04 = ' Fahrzeuge zurückgegeben für ',
    },
    menu = {
        return_header = 'Gebe Fahrzeuge zurück',
        return_text = 'Gebe alle Fahrzeuge zurück und erhalte deine Kaution',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})