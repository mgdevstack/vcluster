
property :web_name, String, name_property: true
property :port, String, default: '80'
property :backend_cluster, Array, required: true
property :root_path, String, default: "/var/wwww/public_html"
property :web_zip_local_path, String, required: true
property :active, [true, false], default: false


action :install do
    Chef::Log.warn("***** LWRP - Platform Family: #{node[:platform_family]}")
    Chef::Log.warn("***** LWRP - Cluster IPs: #{node['vcluster']['backend_app']['cluster_ips']}")

    if node[:platform_family].include?('debian')
        include_recipe "apt"
    end

    package "nginx" do
         action  :install
    end

    service "nginx" do
        action [:enable, :start]
    end
end

action :setup do 

    root_path = ::File.join(new_resource.root_path,new_resource.web_name,'public_html')

    package "unzip"

    directory "#{root_path}" do
        recursive true
        action :create
    end

    template "/etc/nginx/sites-available/#{new_resource.web_name}" do
        source "nginx/vcluster.local.erb"
        mode "0644"
        owner 'root'
        group 'root'
        variables({
            :vcluster_web_root => root_path,
            :app_name => new_resource.web_name,
            :app_cluster => new_resource.backend_cluster,
            :web_port => new_resource.port
            })
    end

    link "/etc/nginx/sites-enabled/default" do
        to "/etc/nginx/sites-available/#{new_resource.web_name}"
        only_if {new_resource.active}
    end

    # bash "update_webapp" do
    #     code "cp -R /vagrant/vcluster_web/* #{root_path}"
    # end

    Chef::Log.warn("Root Path : #{root_path}")
    Chef::Log.warn("local zip path Path : #{new_resource.web_zip_local_path}")
    
    bash "unpack_webapp" do
        user 'root'
        code "unzip #{new_resource.web_zip_local_path} -d #{root_path}"
    end


    service 'nginx' do
        action :restart
    end
end