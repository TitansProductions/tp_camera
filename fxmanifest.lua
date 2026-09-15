fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Nosmakos'
description 'Titans Productions - Camps'
version '1.0.0'

ui_page 'html/index.html'

server_scripts {
    'server/*.lua',
}

client_scripts {
    'client/*.lua',
}

escrow_ignore {
    'client/*.lua',
    'server/*.lua',
}

files { 'html/**/*' }

lua54 'yes'