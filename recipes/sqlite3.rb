
include_recipe 'sqlite'

package 'pdns-backend-sqlite3' do
  package_name value_for_platform(
    'arch' => { 'default' => 'pdns' },
    %w(debian ubuntu) => { 'default' => 'pdns-backend-sqlite3' },
    %w(redhat centos fedora) => { 'default' => 'pdns-backend-sqlite3' },
    'default' => 'pdns-backend-sqlite3'
  )
end

cookbook_file '/var/pdns_schema.sql' do
  source 'sqlite3.schema'
end

ruby_block 'load pdns schema' do
  block do
  end
end
