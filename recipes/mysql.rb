package 'pdns-backend-mysql' do
  package_name value_for_platform(
    'arch' => { 'default' => 'pdns' },
    %w(debian ubuntu) => { 'default' => 'pdns-backend-mysql' },
    %w(redhat centos fedora) => { 'default' => 'pdns-backend-mysql' },
    'default' => 'pdns-backend-mysql'
  )
end

package 'mysql-client'

directory '/var/lib/powerdns' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

passw = node['powerdns']['server']['backend']['passw']
login = node['powerdns']['server']['backend']['login']
host = node['powerdns']['server']['backend']['host']
db = node['powerdns']['server']['backend']['db']

execute 'load_schema' do
  command "mysql -p\"#{passw}\" -u" # {login}\" -h"#{host}\" -D"#{db}\" < /var/lib/powerdns/schema.sql"
  action :nothing
end

cookbook_file '/var/lib/powerdns/schema.sql' do
  source 'mysql.schema'
  notifies :run, 'execute[load_schema]', :immediately
end
