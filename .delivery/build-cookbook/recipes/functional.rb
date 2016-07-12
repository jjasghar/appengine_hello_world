#
# Cookbook Name:: build-cookbook
# Recipe:: functional
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

version_id = node['delivery']['change']['change_id']
account_json = ::File.expand_path('/tmp/gcloud/service_account.json')
src_dir = File.expand_path("#{node['delivery']['workspace']['repo']}")

deployer = Google::ChefConf16::AppengineDeploy.new(
  :app_id => 'formal-platform-134918',
  :app_yaml => "#{src_dir}/app.yaml",
  :service_id => 'default',
  :version_id => version_id,
  :bucket_name => 'chef-conf16-appengine',
  :service_account_json => account_json
)
puts "Application version #{deployer.staging_url}"

case node['delivery']['change']['stage']
when 'acceptance'
  bash "check site images integrity" do
    cwd src_dir
    code <<-EOH
      STATUS=0
      IMAGE_TESTER_AVAILABILITY_TESTS=1 \
        /opt/chefdk/embedded/bin/ruby \
          .delivery/build-cookbook/scripts/site_image_tester.rb \
            #{deployer.staging_url} || STATUS=1
      exit $STATUS
    EOH
  end
end
