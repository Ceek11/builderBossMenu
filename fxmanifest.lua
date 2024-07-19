fx_version "adamant"
game {"gta5"}
lua54 'yes'


client_scripts {
    "src/RMenu.lua",
	"src/menu/RageUI.lua",
	"src/menu/Menu.lua",
	"src/menu/MenuController.lua",
	"src/components/*.lua",
	"src/menu/elements/*.lua",
	"src/menu/items/*.lua",
	"src/menu/panels/*.lua",
}


client_script {
	'@ox_lib/init.lua',
    "client/*.lua",
}


server_script {
	'@oxmysql/lib/MySQL.lua',
    "server/*.lua",
    "config.lua"
}