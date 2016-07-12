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
        site = 'https`://chefconf.chef.io'
        logo = '%s/images/chefconf-logo-88838cbe.svg' % site
        background = '%s/images/hero/home-large-85980001.jpg' % site
        self.response.headers['Content-Type'] = 'text/html'
        self.response.write("""
          <html>
            <style>
              BODY {
                background-color: gray;
                background-image: url('%s');
                background-size: 100%% 100%%;
                font-family: Verdana;
                font-size: 14pt;
              }
              P hello {
                background: #dbe200;
                color: #435363;
                padding: 8pt;
                font-weight: bold;
              }
              P date {
                background: #fdffaf;
                padding: 8pt;
                font-weight: bold;
              }
              .center {
                width: 400px;
                height: 110px;
                position: fixed;
                top: 50%%;
                left: 50%%;
                margin-left: -200px;
                margin-top: -55px;
                text-align: center;
              }
            </style>
            <body>
              <div class='center'>
                <table><tr height='110'><td width='600' align='center'>
                  <img src='%s' width='270' hspace='10' vspace='10'>
                  <p>
                    <hello>Hello, ChefConf!</hello>
                    <date>Today is %s!</date>
                  </p>
                </td></tr></table>
              </div>
            </body>
          </html>
        """ % (background, logo, date.today()))

app = webapp2.WSGIApplication([
    ('/', MainPage),
], debug=True)


def main():
    os.environ['REQUEST_METHOD'] = 'GET'
    os.environ['PATH_INFO'] = '/'
    app.run()

if __name__ == '__main__':
    main()
