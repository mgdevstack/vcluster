resource_name :vcluster_tomcat

property :version, String, default: '8'

action :install do
    
    include_recipe "vcluster::java"
    include_recipe "vcluster::_set_attributes"

    
end