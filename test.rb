# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'dotenv'
require './lib/magister.rb'

Dotenv.load

magister = Magister.new
magister.authenticate(ENV['SCHOOL'], ENV['TOKEN'])
