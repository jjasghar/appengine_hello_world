# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Public: This program takes 1 argument (URL) to inspect. It downloads the HTML
# and fetches each image in the body content, checking for its existance.

# Usage #1:
#     ruby site_image_tester.rb 'https://www.google.com' \
#       && echo 'OK' \
#       || echo 'FAILED'

# Usage #2 (optionally you can fail if no images are found:
#     IMAGE_TESTER_FAIL_IF_NO_IMAGES=1 ruby site_image_tester.rb \
#         'https://images.google.com' \
#       && echo 'OK' \
#       || echo 'FAILED'

require 'net/http'
require 'net/https'
require 'nokogiri'
require 'open-uri'
require 'uri'

healthy = true

fail_if_no_images = ENV['IMAGE_TESTER_FAIL_IF_NO_IMAGES']
site = ARGV[0]

doc = Nokogiri::HTML(open(site))
images = doc.xpath("//img/@src")

if images.length == 0 then
  print "No images found in the document... "
  if fail_if_no_images then
    puts "Failing as 'fail_if_no_images' is set 'true'."
    exit 1
  else
    puts "Nothing to do. Assume success as 'fail_if_no_images' is set 'false'."
  end
end

doc.xpath("//img/@src").each do |src|
  uri = URI.join(site, src)
  print "Checking image #{uri}... "
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = uri.instance_of? URI::HTTPS
  head = Net::HTTP::Head.new(uri.request_uri)
  response = http.request(head)
  if response.instance_of? Net::HTTPOK then
    puts "OK"
  else
    puts "FAILED #{response.class.name.gsub('Net::HTTP', '')}"
    healthy = false
  end
end

exit healthy ? 0 : 1
