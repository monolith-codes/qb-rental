fx_version 'cerulean'
game 'gta5'

description 'qb-rental'
author 'monolith-codes'
version '0.8'

client_script 'client/main.lua'
shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/*.lua',
    'config.lua',
}
server_script 'server/main.lua'