
unless node['powerdns']['server'].nil?
  include_recipe 'powerdns::server'
end
