fx_version 'cerulean'
game 'gta5'

author 'SirRezi'
description 'Tire Slashing Script using ox_target and ox_lib'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'locales/*.lua'
}

client_scripts {
    'client/main.lua'
}

dependencies {
    'ox_lib',
    'ox_target'
}
