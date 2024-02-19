# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'dotenv'
require 'magister'
require 'json'

Dotenv.load

magister = Magister.new

magister.login(ENV["SCHOOL"], ENV["_USERNAME"], ENV["PASSWORD"])

magister.profile.verify

puts
puts "user id: #{magister.profile.id}; school: #{magister.profile.school}"
puts "Welcome #{magister.profile.person["Roepnaam"]} #{magister.profile.person["Achternaam"]}"

magister.get_classes("2024-02-26", "2024-03-04").each do |cls|
    puts cls.inspect
    puts
end