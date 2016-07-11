#
# Cookbook Name:: build-cookbook
# Recipe:: security
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# TODO(jj): Extract the dynamic URL from the appengine resource
staging_site_url = 'https://www.google.com'

src_dir = File.expand_path("#{node['delivery']['workspace']['repo']}")

bash "check site images integrity" do
  cwd src_dir
  code <<-EOH
    STATUS=0
    IMAGE_TESTER_SECURITY_TESTS=1 \
      ruby .build-cookbook}/scripts/site_image_tester.rb #{staging_site_url} || STATUS=1
    exit $STATUS
  EOH
end
