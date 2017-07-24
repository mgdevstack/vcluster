#
# Cookbook:: vcluster
# Recipe:: web_lwrp
#
# Copyright:: 2017, Mayank Gaikwad, All Rights Reserved.
# Description : Uses LWRP to deploy web application


vcluster_web "vcluster.lwrp" do
    port '80'
    root_path "/var/www"  #Default: /var/www/public_html
    web_zip_local_path node['vcluster']['web']['local_path']  #required attr, /vagrant/vcluster_web/web.zip
    backend_cluster node['vcluster']['backend_app']['cluster_ips'] # Array
    active true
    action [:install, :setup]
end