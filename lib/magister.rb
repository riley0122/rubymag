# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require './lib/magister/profile.rb'

class Magister
    def initialize
        @profile = nil
    end

    def authenticate(school, token)
        @profile = Profile.new(token, school)
        @profile.verify
    end
end
