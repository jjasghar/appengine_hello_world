#
# Cookbook Name:: build-cookbook
# Recipe:: functional
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

src_dir = File.expand_path("#{node['delivery']['workspace']['repo']}")

# TODO(jj): Extract the dynamic URL from the appengine resource
staging_site_url = 'https://www.google.com'

bash "check site images integrity" do
  cwd src_dir
  code <<-EOH
    STATUS=0
    IMAGE_TESTER_AVAILABILITY_TESTS=1 \
    /opt/chefdk/embedded/bin/ruby .delivery/scripts/site_image_tester.rb #{staging_site_url} || STATUS=1
    exit $STATUS
  EOH
end
