#
# Cookbook Name:: build-cookbook
# Recipe:: functional
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

src_dir = File.expand_path("#{node['delivery']['workspace']['repo']}")

# TODO(jj): Extract the dynamic URL from the appengine resource
staging_site_url = 'https://www.google.com'

image_checker_logfile="/tmp/build-functional-#{ENV['CHEF_PUSH_JOB_ID']}.log"

bash "check site images integrity" do
  cwd src_dir
  code <<-EOH
    STATUS=0
    IMAGE_TESTER_AVAILABILITY_TESTS=1 \
      /opt/chefdk/embedded/bin/ruby \
        .delivery/build-cookbook/scripts/site_image_tester.rb \
          #{staging_site_url} | tee #{image_checker_logfile}
    cat #{image_checker_logfile}
    STATUS=$?
    exit $STATUS
  EOH
end

output=`cat #{image_checker_logfile}`
Chef::Log.info output

File.delete(image_checker_logfile)
