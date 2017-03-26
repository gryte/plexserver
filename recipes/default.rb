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
