#
# Cookbook:: vcluster
# Recipe:: web_deploy
#
# Copyright:: 2017, Mayank Gaikwad, All Rights Reserved.

directory "#{node['vcluster']['web']['app_root']}" do
    recursive true
    action :create
end

link "/etc/nginx/sites-enabled/default" do
    to "/etc/nginx/sites-available/#{node['vcluster']['web']['app_name']}"
end

# bash "update_webapp" do
#     code "cp -R /vagrant/vcluster_web/* #{node['vcluster']['web']['app_root']}"
# end

bash "unpack_webapp" do
    code "unzip #{node['vcluster']['web']['local_path']} -d #{node['vcluster']['web']['app_root']}"
end