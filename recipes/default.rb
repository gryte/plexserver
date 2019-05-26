#
# Cookbook:: plexserver
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# enable platform default firewall
firewall 'default' do
  action :install
end

# download plex media server rpm
remote_file '/tmp/plexmediaserver-1.15.4.994-107756f7e.x86_64.rpm' do
  source 'https://downloads.plex.tv/plex-media-server-new/1.15.4.994-107756f7e/redhat/plexmediaserver-1.15.4.994-107756f7e.x86_64.rpm'
  action :create
  retries 3
  retry_delay 2
end

# install plex rpm
package 'plex' do
  package_name 'plexmediaserver'
  action :install
  source '/tmp/plexmediaserver-1.15.4.994-107756f7e.x86_64.rpm'
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
