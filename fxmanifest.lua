fx_version 'cerulean'
game 'gta5'

author 'Fluxion Scripts'
version '1.0.0'

lua54 'yes'

shared_scripts { '@es_extended/imports.lua', '@ox_lib/init.lua' }

server_scripts {
	'src/server.lua',
}
dependencies {
	'es_extended',
}
