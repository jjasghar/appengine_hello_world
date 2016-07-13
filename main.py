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

from datetime import date
import os
import webapp2


class MainPage(webapp2.RequestHandler):
    def get(self):
        root = 'https://storage.googleapis.com/caps-staging'
        google_logo = '%s/cloud_platform_icon_horizontal_new.png' % root
        chef_logo = '%s/chef_logo.svg' % root
        style = '%s/site.css?v=2' % root
        self.response.headers['Content-Type'] = 'text/html'
        self.response.write("""
          <html>
            <head>
              <link rel="stylesheet" type="text/css" href="%(style)s">
            </head>
            <body>
              <img id='goog' src='%(google)s'>
              <table width='100%%' height='100%%'>
                <tr valign='middle'><td align='center'>
                <img src='%(chef)s' width='270' hspace='10' vspace='10'>
                <p>
                  <hello>Hello, ChefConf!</hello><!--
                  --><date>Today is %(today)s!</date>
                </p>
              </td></tr></table>
            </body>
          </html>
        """ % {
                'style': style,
                'chef': chef_logo,
                'today': date.today(),
                'google': google_logo,
              })

app = webapp2.WSGIApplication([
    ('/', MainPage),
], debug=True)


def main():
    os.environ['REQUEST_METHOD'] = 'GET'
    os.environ['PATH_INFO'] = '/'
    app.run()

if __name__ == '__main__':
    main()
