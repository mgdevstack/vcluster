
if node['vcluster']['tomcat']['major_version'] == '8'
    node.override['vcluster']['tomcat']['version'] = node['vcluster']['tomcat']['8']['version']
    node.override['vcluster']['tomcat']['url'] = node['vcluster']['tomcat']['8']['url']
    node.override['vcluster']['tomcat']['checksum'] = node['vcluster']['tomcat']['8']['checksum']
    node.override['vcluster']['tomcat']['install_path'] = ::File.join("#{node['vcluster']['tomcat']['base_path']}","#{node['vcluster']['tomcat']['8']['version']}")
    node.override['vcluster']['tomcat']['catalina_home'] = node['vcluster']['tomcat']['install_path']
end