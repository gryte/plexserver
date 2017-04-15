#
# Cookbook:: plexserver
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# install wget
package 'wget' do
  action :install
end

# download plex rpm
remote_file 'plex-rpm_download' do
  not_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/plexmediaserver-1.4.4.3495-edef59192.x86_64.rpm") }
  path "#{Chef::Config[:file_cache_path]}/plexmediaserver-1.4.4.3495-edef59192.x86_64.rpm"
  source 'https://downloads.plex.tv/plex-media-server/1.4.4.3495-edef59192/plexmediaserver-1.4.4.3495-edef59192.x86_64.rpm'
end

# install plex rpm
package 'plex-rpm' do
  source "#{Chef::Config[:file_cache_path]}/plexmediaserver-1.4.4.3495-edef59192.x86_64.rpm"
  action :install
  notifies :restart, 'service[plexmediaserver]'
end

# plexmediaserver service
service 'plexmediaserver' do
  action :enable
end

# firewalld service
service 'firewalld' do
  action [:enable, :start]
end

# reload firewalld config
execute 'firewalld_reload' do
  command 'firewall-cmd --reload'
  action :nothing
  notifies :run, 'execute[firewalld_regservice]', :immediately
end

# register firewalld rules
execute 'firewalld_regservice' do
  command 'firewall-cmd --permanent --add-service=plexmediaserver'
  action :nothing
  notifies :run, 'execute[firewalld_regzone]', :immediately
end

# register firewalld zone
execute 'firewalld_regzone' do
  command 'firewall-cmd --permanent --zone=public --add-service=plexmediaserver'
  action :nothing
  notifies :restart, 'service[firewalld]'
end

# create firewalld service file
cookbook_file '/etc/firewalld/services/plexmediaserver.xml' do
  source 'plexmediaserver.xml'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[firewalld_reload]', :immediately
end

# enable plex repo
yum_repository 'plex' do
  description 'PlexRepo'
  baseurl "https://downloads.plex.tv/repo/rpm/$basearch/"
  gpgkey 'https://downloads.plex.tv/plex-keys/PlexSign.key'
  gpgcheck true
  enabled true
  action :create
end
