# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'dotenv'
require 'magister'

Dotenv.load

magister = Magister.new

magister.login(ENV["SCHOOL"], ENV["_USERNAME"], ENV["PASSWORD"])

magister.profile.verify

puts
puts "user id: #{magister.profile.id}; school: #{magister.profile.school}"
puts "Welcome #{magister.profile.person["Roepnaam"]} #{magister.profile.person["Achternaam"]}"
