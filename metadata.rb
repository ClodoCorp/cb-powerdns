name 'powerdns'
maintainer 'Vasiliy Tolstov'
maintainer_email 'v.tolstov@selfip.ru'
license 'MIT'
description 'Installs/Configures powerdns server and recursor'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'

depends 'mysql'
depends 'sqlite'

recipe 'powerdns',         'Runs specific recipe'
recipe 'powerdns::server', 'Installs powerdns server'
recipe 'powerdns::mysql',  'Installs powerdns mysql backend'
recipe 'powerdns::sqlite3',  'Installs powerdns sqlite3 backend'
