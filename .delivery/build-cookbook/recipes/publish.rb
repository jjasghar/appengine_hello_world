#
# Cookbook Name:: build-cookbook
# Recipe:: publish
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

git node.default['appengine']['source_location'] do
  repository node.default['appengine']['repository']
  reference  node.default['appengine']['branch']
  user 'root'
  group 'root'
  action :sync
end
