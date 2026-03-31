fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'Soos'
description 'Job Garage System'
version '1.0.0'

client_scripts {
  'client/*.lua'
}

server_scripts {
  'server/*.lua',
  '@oxmysql/lib/MySQL.lua'
}

shared_scripts {
  '@es_extended/imports.lua',
  '@es_extended/locale.lua',
  'config.lua',
  'locales/*.lua'
}

dependencies {
  'es_extended',
  'oxmysql'
}

escrow_ignore {
  'config.lua',
  'locales/*.lua',
  'server/*.lua',
  'client/*.lua',
  'soos_garage.sql'
}