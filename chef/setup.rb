package 'tree' do
  action :install
end

file '/home/bschoenrock/Sandbox/chef/motd' do
  content 'Property of Charter Communications chef Lab!'
end
