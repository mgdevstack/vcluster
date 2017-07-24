#
# Cookbook:: vcluster
# Recipe:: nginx
#
# Copyright:: 2017, Mayank Gaikwad, All Rights Reserved.

Chef::Log.warn("***** Platform Family: #{node[:platform_family]}")
Chef::Log.warn("***** Cluster IPs: #{node['vcluster']['backend_app']['cluster_ips']}")

if node[:platform_family].include?('debian')
    include_recipe "apt"
end

directory "#{node['vcluster']['web']['app_root']}" do
    recursive true
    action :create
end

package "unzip"

package "nginx" do
     action  :install
end

template "/etc/nginx/sites-available/#{node['vcluster']['web']['app_name']}" do
    source "nginx/vcluster.local.erb"
    mode "0644"
    owner 'root'
    group 'root'
    variables({
        :vcluster_web_root => node['vcluster']['web']['app_root'],
        :app_name => node['vcluster']['web']['app_name'],
        :app_cluster => node['vcluster']['backend_app']['cluster_ips'],
        :web_port => '80'
        })
end

service "nginx" do
    action [:enable, :start]
end