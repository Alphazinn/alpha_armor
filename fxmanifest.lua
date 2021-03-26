fx_version 'adamant'
game 'gta5'

author 'Alpha'
description 'Alpha Armor'
version '1.1.0'

client_script "client/client.lua"

server_scripts { 
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}
