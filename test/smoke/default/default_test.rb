# # encoding: utf-8

# Inspec test for recipe plexserver::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

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

# firewalld service is enabled and running
describe service('firewalld') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# plex port 32400 is listening
describe port(32_400) do
  it { should be_listening }
end

# iptables is configured
describe iptables(chain: 'INPUT_direct') do
  it { should have_rule('-A INPUT_direct -p tcp -m tcp -m multiport --dports 2049 -m comment --comment nfs-tcp -j ACCEPT') }
  it { should have_rule('-A INPUT_direct -p udp -m multiport --dports 2049 -m comment --comment nfs-udp -j ACCEPT') }
  it { should have_rule('-A INPUT_direct -p tcp -m tcp -m multiport --dports 111 -m comment --comment rpcbind-sunrpc-tcp -j ACCEPT') }
  it { should have_rule('-A INPUT_direct -p udp -m multiport --dports 111 -m comment --comment rpcbind-sunrpc-udp -j ACCEPT') }
  it { should have_rule('-A INPUT_direct -p tcp -m tcp -m multiport --dports 22 -m comment --comment ssh -j ACCEPT') }
  it { should have_rule('-A INPUT_direct -p udp -m multiport --dports 1900 -m comment --comment plex-dlna-udp -j ACCEPT') }
  it { should have_rule('-A INPUT_direct -p tcp -m tcp -m multiport --dports 3005 -m comment --comment plex-htc-cmpn -j ACCEPT') }
  it { should have_rule('-A INPUT_direct -p udp -m multiport --dports 5353 -m comment --comment bonjour-avahi -j ACCEPT') }
  it { should have_rule('-A INPUT_direct -p tcp -m tcp -m multiport --dports 8324 -m comment --comment plex-roku-cmpn -j ACCEPT') }
  it { should have_rule('-A INPUT_direct -p udp -m multiport --dports 32410:32414 -m comment --comment gdm-ntwrk-dscvry -j ACCEPT') }
  it { should have_rule('-A INPUT_direct -p tcp -m tcp -m multiport --dports 32469 -m comment --comment plex-dlna-tcp -j ACCEPT') }
  it { should have_rule('-A INPUT_direct -p tcp -m tcp -m multiport --dports 32400 -m comment --comment plex-web -j ACCEPT') }
end

# plex repo exists and is enabled
describe yum.repo('PlexRepo') do
  it { should exist }
  it { should be_enabled }
end
