# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require './lib/magister/profile.rb'
require './lib/magister/data.rb'
require './lib/magister/authenticator.rb'

# can be either "selenium" or "local"
# "selenium" will run headlessly
# "local" will open a browser window for the user to login
$authMode = "selenium"

class Magister
    include MagisterData

    def initialize
        @profile = nil
    end

    def authenticate(school, token)
        @profile = Profile.new(token, school)
        @profile.verify
    end
    def login(school, username, password)
        @profile = authenticator.login(username, password, school)
    end

    def profile
        @profile
    end
end
