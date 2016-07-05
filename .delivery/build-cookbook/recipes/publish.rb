#
# Cookbook Name:: build-cookbook
# Recipe:: publish
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

src_dir = File.expand_path("#{node['delivery']['workspace']['repo']}/")

git "#{src_dir}/#{node.default['appengine']['source_location']}" do
  repository node.default['appengine']['repository']
  reference  node.default['appengine']['branch']
  user 'dbuild'
  group 'dbuild'
  action :sync
end
