
node.default['apt']['compile_time_update'] = true

# default['vcluster']['web']['root'] = "/usr/share/nginx/vcluster_web"
default['vcluster']['web']['app_path'] = "/var/www"
default['vcluster']['web']['app_name'] = "vcluster.local"
default['vcluster']['web']['app_root'] = ::File.join("#{node['vcluster']['web']['app_path']}","#{node['vcluster']['web']['app_name']}","public_html")
default['vcluster']['web']['local_path'] = "/vagrant/vcluster_web/web.zip"  #Download from central repo and keep on localpath
default['vcluster']['web']['ip'] = ""
default['vcluster']['environment'] = ""