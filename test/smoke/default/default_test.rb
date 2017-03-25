# # encoding: utf-8

# Inspec test for recipe plexserver::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# wget is installed
describe package('wget') do
  it { should be_installed }
end
