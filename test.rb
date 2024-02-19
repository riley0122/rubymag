# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'dotenv'
require './lib/magister.rb'
require './lib/magister/authenticator.rb'

Dotenv.load

magister = Magister.new
magister.login(ENV["SCHOOL"], ENV["USERNAME"], ENV["PASSWORD"])

puts magister.profile.id
puts magister.profile.school
puts magister.get_classes("2024-02-25", "2024-03-05")