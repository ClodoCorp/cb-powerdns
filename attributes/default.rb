case node['platform_family']
when 'rhel', 'fedora'
  default['pdns']['user'] = 'pdns-recursor'
  default['powerdns']['group'] = 'pdns-recursor'
else
  default['powerdns']['user'] = 'pdns'
  default['powerdns']['group'] = 'pdns'
end

default['powerdns']['recursor']['allow_from'] = [
  '127.0.0.0/8',
  '10.0.0.0/8',
  '192.168.0.0/16',
  '172.16.0.0/12',
  '::1/128',
  'e80::/10'
]

default['powerdns']['recursor']['auth_zones'] = []
default['powerdns']['recursor']['forward_zones'] = []
default['powerdns']['recursor']['forward_zones_recurse'] = []
default['powerdns']['recursor']['local_address'] = [ipaddress]
default['powerdns']['recursor']['local_port'] = '53'
