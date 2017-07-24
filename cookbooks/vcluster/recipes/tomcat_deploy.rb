#
# Cookbook:: vcluster
# Recipe:: tomcat_deploy
#
# Copyright:: 2017, Mayank Gaikwad, All Rights Reserved.

# Download build from central repository to /tmp and then deploy on CATALINA_HOME
# remote_file "#{node['vcluster']['tomcat']['install_path']}/webapps/sample.war" do
#     source 
# end

# Assuming currently build is in cookbook
# cookbook_file "#{node['vcluster']['tomcat']['install_path']}/webapps/sample.war" do
#     source "sample.war"
#     user "#{node['vcluster']['tomcat']['user']}"
#     notifies :restart, "service[tomcat8]", :immediate
# end

# Application .war can be pulled from remote server and keep on local cache path
remote_file "#{node['vcluster']['tomcat']['install_path']}/webapps/sample.war" do
    source "file://#{node['vcluster']['tomcat']['war']['local_path']}/sample.war"
    user "#{node['vcluster']['tomcat']['user']}"
    notifies :restart, "service[tomcat8]", :immediate
end


# Updating html and jsp assets during deployment
template "#{node['vcluster']['tomcat']['install_path']}/webapps/sample/index.html" do
    source "tomcat/index.html.erb"
    user 'root'
    owner 'root'
    mode '0644'
    variables({
        :frontend_box_ip => node['vcluster']['web']['ip']
        })
end

template "#{node['vcluster']['tomcat']['install_path']}/webapps/sample/hello.jsp" do
    source "tomcat/hello.jsp.erb"
    user 'root'
    owner 'root'
    mode '0644'
    variables({
        :chef_environment => node['vcluster']['environment'],
        :frontend_box_ip => node['vcluster']['web']['ip']
        })
end

service 'tomcat8' do
  action [:restart]
end