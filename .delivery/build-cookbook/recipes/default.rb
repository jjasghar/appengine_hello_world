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

bash "install pip" do
  cwd src_dir
  creates "/etc/yum.repos.d/epel.repo"
  code <<-EOH
    STATUS=0
    rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-7.noarch.rpm || STATUS=1
    exit $STATUS
  EOH
  only_if { node['platform'] == 'redhat' || node['platform'] == 'centos' }
end

package 'python-devel' do
  action :install
  only_if { node['platform'] == 'redhat' || node['platform'] == 'centos' }
end

package 'python-cffi' do
  action :install
  only_if { node['platform'] == 'redhat' || node['platform'] == 'centos' }
end

package 'python-pip' do
  action :install
  only_if { node['platform'] == 'redhat' || node['platform'] == 'centos' }
end

bash "install pep8" do
  cwd src_dir
  code <<-EOH
    STATUS=0
    pip install pep8 || STATUS=1
    exit $STATUS
  EOH
end
