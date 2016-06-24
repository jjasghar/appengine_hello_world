#
# Cookbook Name:: build-cookbook
# Recipe:: syntax
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

src_dir = File.expand_path("#{node['delivery']['workspace']['repo']}/")

bash "check the python script" do
  user "root"
  cwd src_dir
  code <<-EOH
    STATUS=0
    python -m py_compile main.py  || STATUS=1
    exit $STATUS
  EOH
end
