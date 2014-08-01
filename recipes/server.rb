
include_recipe "powerdns::#{node['powerdns']['server']['backend']}"

package 'pdns' do
  package_name value_for_platform(
    %w(debian ubuntu) => { 'default' => 'pdns-server' },
    'default' => 'pdns'
  )
end

service node['powerdns']['server']['service'] do
  action [:enable, :start]
end

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
