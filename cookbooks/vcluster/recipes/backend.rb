#
# Cookbook:: vcluster
# Recipe:: backend
#
# Copyright:: 2017, Mayank Gaikwad, All Rights Reserved.
#
# Description: THis configures backed tomcat system

include_recipe "vcluster::tomcat"
include_recipe "vcluster::tomcat_deploy"