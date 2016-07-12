#
# Cookbook Name:: build-cookbook
# Recipe:: lint
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

src_dir = File.expand_path("#{node['delivery']['workspace']['repo']}/")

require 'pp'
pp node

bash "install pep8" do
  cwd src_dir
  code <<-EOH
    STATUS=0
    /opt/chefdk/embedded/bin/gem environment
    pip install pep8  || STATUS=1
    exit $STATUS
  EOH
end

bash "check the python script" do
  cwd src_dir
  code <<-EOH
    STATUS=0
    pep8 --first main.py  || STATUS=1
    exit $STATUS
  EOH
end
