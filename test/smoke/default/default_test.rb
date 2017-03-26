# # encoding: utf-8

# Inspec test for recipe plexserver::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# wget is installed
describe package('wget') do
  it { should be_installed }
end

# plex rpm is installed
describe package('plexmediaserver') do
  it { should be_installed }
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
describe http('http://localhost:32400/web/index.html') do
  its('status') { should cmp 200 }
end

# iptables is configured
describe iptables(chain: 'IN_public_allow') do
  it { should have_rule('-A IN_public_allow -p udp -m udp --dport 1900 -m conntrack --ctstate NEW -j ACCEPT') }
  it { should have_rule('-A IN_public_allow -p tcp -m tcp --dport 3005 -m conntrack --ctstate NEW -j ACCEPT') }
  it { should have_rule('-A IN_public_allow -p udp -m udp --dport 5353 -m conntrack --ctstate NEW -j ACCEPT') }
  it { should have_rule('-A IN_public_allow -p tcp -m tcp --dport 8324 -m conntrack --ctstate NEW -j ACCEPT') }
  it { should have_rule('-A IN_public_allow -p udp -m udp --dport 32410 -m conntrack --ctstate NEW -j ACCEPT') }
  it { should have_rule('-A IN_public_allow -p udp -m udp --dport 32412 -m conntrack --ctstate NEW -j ACCEPT') }
  it { should have_rule('-A IN_public_allow -p udp -m udp --dport 32413 -m conntrack --ctstate NEW -j ACCEPT') }
  it { should have_rule('-A IN_public_allow -p udp -m udp --dport 32414 -m conntrack --ctstate NEW -j ACCEPT') }
  it { should have_rule('-A IN_public_allow -p tcp -m tcp --dport 32469 -m conntrack --ctstate NEW -j ACCEPT') }
  it { should have_rule('-A IN_public_allow -p tcp -m tcp --dport 32400 -m conntrack --ctstate NEW -j ACCEPT') }
end
