resource_name :vcluster_java

property :version, String, default: '8'

action :install do
    include_recipe "java"
end