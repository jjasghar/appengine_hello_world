#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

src_dir = File.expand_path("#{node['delivery']['workspace']['repo']}/")

include_recipe "appengine::default"
include_recipe "build-essential::default"
include_recipe "poise-python::default"

package 'libffi' do
  case node[:platform]
  when 'redhat', 'centos'
    package_name 'libffi'
  when 'ubuntu', 'debian'
    package_name 'libffi-dev'
  end
  action :install
end

bash "install pep8" do
  cwd src_dir
  code <<-EOH
    STATUS=0
    pip install --upgrade ndg-httpsclient || STATUS=1
    pip install pep8  || STATUS=1
    exit $STATUS
  EOH
end
