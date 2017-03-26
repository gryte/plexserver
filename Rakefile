desc 'Define default task'
task default: [:cookstyle, :foodcritic]

desc 'Run cookstyle'
task :cookstyle do
  sh 'cookstyle'
end

desc 'Run foodcritic in current directory'
task :foodcritic do
  sh 'foodcritic .'
end

desc 'Knife upload plexserver cookbook to test environment'
task :upload_test do
  sh 'knife cookbook upload -o .. plexserver -E test'
end

desc 'Knife upload plexserver cookbook to prod environment'
task :upload_prod do
  sh 'knife cookbook upload -o .. plexserver -E prod'
end

desc 'Delete testserver node'
task :deletenode_test do
  sh 'knife node delete testserver -y'
end

desc 'Delete testserver client'
task :deleteclient_test do
  sh 'knife client delete testserver -y'
end

desc 'Remove testserver from chef server'
task remove_test: [:deletenode_test, :deleteclient_test]

desc 'Bootstrap test server'
task bootstrap_test: [:upload_test] do
  `sh 'knife bootstrap 192.168.1.211
  -E test
  -N testserver
  -r plexserver
  --sudo
  --ssh-user test
  --ssh-password test
  --use-sudo-password'`
end
