#
# Cookbook:: vcluster
# Recipe:: tomcat
#
# Copyright:: 2017, Mayank Gaikwad, All Rights Reserved.

include_recipe "vcluster::java"
include_recipe "vcluster::_set_attributes"

node_cache_path = Chef::Config[:file_cache_path]

group "#{node['vcluster']['tomcat']['group']}" do
  action :create
end

user "#{node['vcluster']['tomcat']['user']}" do
    comment "apache tomcat system account"
    gid "#{node['vcluster']['tomcat']['group']}"
    system true
    home "/usr/share/#{node['vcluster']['tomcat']['user']}"
    shell '/bin/bash'
end

#Download tomcat archive
remote_file "#{node_cache_path}/#{node['vcluster']['tomcat']['version']}.tar.gz" do
    source node['vcluster']['tomcat']['url']
    owner node['vcluster']['tomcat']['user']
    group node['vcluster']['tomcat']['group']
    mode '0644'
    action :create
end

#create tomcat install dir
directory node['vcluster']['tomcat']['install_path'] do
    owner node['vcluster']['tomcat']['user']
    group node['vcluster']['tomcat']['group']
    mode '0755'
    action :create
end

#Extract the tomcat archive to the install location
bash 'Extract tomcat archive' do
    cwd node['vcluster']['tomcat']['base_path']
    user node['vcluster']['tomcat']['user']
    group node['vcluster']['tomcat']['group']
    code <<-EOH
    tar -zxvf #{node_cache_path}/#{node['vcluster']['tomcat']['version']}.tar.gz
    EOH
    action :run
    not_if {::File.directory?("#{node['vcluster']['tomcat']['install_path']}/webapps")}
end


#Install init script (Depricated)
# template "/etc/init.d/tomcat8" do
#     source 'tomcat8.erb'
#     owner 'root'
#     mode '0755'
#     variables({
#         :java_options =>  node['vcluster']['tomcat']['java_options'],
#         :install_path =>  node['vcluster']['tomcat']['install_path']
#     })
# end

#Install init script
template "/etc/init.d/tomcat8" do
    source 'tomcat/tomcat8.init.erb'
    user 'root'
    owner 'root'
    mode '0755'
    variables({
        :java_options =>  node['vcluster']['tomcat']['java_options'],
        :catalina_home =>  node['vcluster']['tomcat']['install_path']
    })
end

#Start and enable tomcat service if requested
service 'tomcat8' do
    supports :restart => true, :reload => true, :status => true 
    action [:enable, :start]
    only_if { node['vcluster']['tomcat']['autostart'] }
end
