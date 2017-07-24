

default['vcluster']['tomcat']['major_version'] = '8'
default['vcluster']['tomcat']['user'] = 'tomcat8'
default['vcluster']['tomcat']['group'] = 'tomcat8'
default['vcluster']['tomcat']['base_path'] = '/opt'
default['vcluster']['tomcat']['autostart'] = true
default['vcluster']['tomcat']['java_options'] = ""  # -Xms512m -Xmx1024m
default['vcluster']['tomcat']['war']['local_path'] = "/vagrant/vcluster_app"  # -Xms512m -Xmx1024m

default['vcluster']['tomcat']['8']['version'] = 'apache-tomcat-8.0.30'
default['vcluster']['tomcat']['8']['url'] = 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.30/bin/apache-tomcat-8.0.30.tar.gz'
default['vcluster']['tomcat']['8']['checksum'] = '2fc3dde305e08388a12bd2868063ab6829a1d70acd9affe3a8707bd9679e0059'

default['vcluster']['backend_app']['cluster_ips'] =[]