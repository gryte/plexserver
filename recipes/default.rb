#
# Cookbook:: plexserver
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# enable platform default firewall
firewall 'default' do
  action :install
end

plexserver_package = node['plexserver']['package']['name']
plexserver_url = node['plexserver']['version']['url']

# download plex media server rpm
remote_file "#{Chef::Config[:file_cache_path]}/#{plexserver_package}" do
  source plexserver_url
  action :create
  retries 3
  retry_delay 2
end

# install plex rpm
package 'plex' do
  package_name 'plexmediaserver'
  action :install
  source "#{Chef::Config[:file_cache_path]}/#{plexserver_package}"
  notifies :restart, 'service[plexmediaserver]'
end

# plexmediaserver service
service 'plexmediaserver' do
  action :enable
end

# open ports for access to the Plex DLNA Server
firewall_rule 'plex-dlna-udp' do
  protocol :udp
  port 1900
  command :allow
end

firewall_rule 'plex-dlna-tcp' do
  protocol :tcp
  port 32469
  command :allow
end

# open ports for controlling Plex Home Theater via Plex Companion
firewall_rule 'plex-htc-cmpn' do
  protocol :tcp
  port 3005
  command :allow
end

# open ports for older Bonjour/Avahi network discovery
firewall_rule 'bonjour-avahi' do
  protocol :udp
  port 5353
  command :allow
end

# open ports for controlling Plex for Roku via Plex Companion
firewall_rule 'plex-roku-cmpn' do
  protocol :tcp
  port 8324
  command :allow
end

# open ports for current GDM network discovery
firewall_rule 'gdm-ntwrk-dscvry' do
  protocol :udp
  port 32410..32414
  command :allow
end

# open port for plex web access
firewall_rule 'plex-web' do
  protocol :tcp
  port 32400
  command :allow
end

# open ports for nfs
firewall_rule 'nfs-tcp' do
  protocol :tcp
  port 2049
  command :allow
end

firewall_rule 'nfs-udp' do
  protocol :udp
  port 2049
  command :allow
end

# open ports for rpcbind/sunrpc
firewall_rule 'rpcbind-sunrpc-tcp' do
  protocol :tcp
  port 111
  command :allow
end

firewall_rule 'rpcbind-sunrpc-udp' do
  protocol :udp
  port 111
  command :allow
end

# open port for ssh connections
firewall_rule 'ssh' do
  port 22
  command :allow
end
