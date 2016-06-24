#
# Cookbook Name:: build-cookbook
# Recipe:: lint
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

src_dir = File.expand_path("#{node['delivery']['workspace']['repo']}/")

bash "install pep8" do
  user "root"
  cwd src_dir
  code <<-EOH
    STATUS=0
    pip install pep8  || STATUS=1
    exit $STATUS
  EOH
end

bash "check the python script" do
  user "root"
  cwd src_dir
  code <<-EOH
    STATUS=0
    pep8 --first main.py  || STATUS=1
    exit $STATUS
  EOH
end
