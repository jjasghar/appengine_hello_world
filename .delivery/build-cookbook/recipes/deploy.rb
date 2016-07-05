#
# Cookbook Name:: build-cookbook
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

account_json = ::File.expand_path('/tmp/gcloud/service_account.json')

src_dir = File.expand_path("#{node['delivery']['workspace']['repo']}/")

appengine 'formal-platform-134918' do
  app_yaml "#{node.default['appengine']['source_location']}/app.yaml"
  service_id 'default'
  bucket_name 'chef-conf16-appengine'
  service_account_json account_json
  source "#{src_dir}/#{node.default['appengine']['source_location']}"
end
