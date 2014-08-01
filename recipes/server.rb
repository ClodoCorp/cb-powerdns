
include_recipe "powerdns::#{node['powerdns']['server_backend']['type']}"

package 'pdns' do
  package_name value_for_platform(
    %w(debian ubuntu) => { 'default' => 'pdns-server' },
    'default' => 'pdns'
  )
end

service node['powerdns']['server']['service'] do
  action [:enable, :start]
end

node.set['powerdns']['server']['launch'] = 'gmysql'
node.set['powerdns']['server']['gmysql-dnssec'] = true
node.set['powerdns']['server']['gmysql-host'] = node['powerdns']['server_backend']['host']
node.set['powerdns']['server']['gmysql-user'] = node['powerdns']['server_backend']['login']
node.set['powerdns']['server']['gmysql-password'] = node['powerdns']['server_backend']['passw']
node.set['powerdns']['server']['gmysql-dbname'] = node['powerdns']['server_backend']['db']

template '/etc/powerdns/pdns.conf' do
  source 'pdns.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables { { variables: node['powerdns']['server'] } }
  notifies :reload, "service[#{node['powerdns']['server']['service']}]", :immediately
end

directory node['powerdns']['server']['conf.d'] do
  owner 'root'
  group 'root'
  mode 0755
end
