# # encoding: utf-8

# Inspec test for recipe plexserver::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# wget is installed
describe package('wget') do
  it { should be_installed }
end

# plex rpm is installed
describe command('rpm -V plexmediaserver-1.4.4.3495-edef59192.x86_64.rpm') do
  its('stdout') { should eq '' }
end

# plex service is enabled and running
describe service('plexmediaserver') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# plex port 32400 is listening
describe port(32_400) do
  it { should be_listening }
end

# plex web app is running
describe http('http://localhost:32400/web') do
  its('status') { should eq 200 }
end
