# # encoding: utf-8

# Inspec test for recipe plexserver::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# wget is installed
describe package('wget') do
  it { should be_installed }
end

# download directory exists
describe directory('/tmp') do
  it { should be_directory }
end

# plex rpm file exists
describe file('/tmp/plexmediaserver-1.4.4.3495-edef59192.x86_64.rpm') do
  it { should be_file }
end
