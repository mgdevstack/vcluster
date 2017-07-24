#
# Cookbook:: vcluster
# Recipe:: frontend
#
# Copyright:: 2017, Mayank Gaikwad, All Rights Reserved.
#
# Description: This configures nginx and deploys webapplication


# ============   Method - 1 Custom Recipes  ===============

# include_recipe "vcluster::nginx"
# include_recipe "vcluster::web_deploy"

# =========================================================



# ============   Method - 2 LWRP Way  (comment out method -1 block )  ================

include_recipe "vcluster::web_lwrp"

# ====================================================================================