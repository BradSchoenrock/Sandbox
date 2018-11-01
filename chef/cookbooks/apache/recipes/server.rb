#
# Cookbook:: apache
# Recipe:: server
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'httpd' do
  action :install
end

file '/var/www/html/index.html' do
  content "<h1> Hello, World!</h1>
  <h4>IPADDRESS: #{node['ipaddress']}</h4>
  <h4>HOSTNAME: #{node['hostname']}</h4>
  <h4>MEMORY: #{node['memory']['total']}</h4>
  <h4>CPU: #{node['cpu']['0']['mhz']}</h4>

  "
  
  action :create
end

service 'httpd' do
  action [:enable, :start]
end
