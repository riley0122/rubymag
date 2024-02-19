# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'dotenv'
require 'magister'
require 'magister/types/subject'
require 'json'

Dotenv.load

magister = Magister.new

magister.login(ENV["SCHOOL"], ENV["_USERNAME"], ENV["PASSWORD"])

magister.profile.verify

puts
puts "user id: #{magister.profile.id}; school: #{magister.profile.school}"
puts "Welcome #{magister.profile.person["Roepnaam"]} #{magister.profile.person["Achternaam"]}"

puts "===================="
puts
puts "classes on 2024-02-26"
puts
puts "===================="
puts
magister.get_classes("2024-02-26", "2024-02-26").each do |cls|
    puts "#{cls.subjects[0].name} | #{cls.description} | #{cls.location}"
end

puts
puts "===================="
puts
puts "latest 3 grades"
puts
puts "===================="
puts

magister.get_grades(3).each do |g|
    if g.isSufficient
        puts "|✓| #{g.description} | #{g.weight}x #{g.grade}"
    else
        puts "|X| #{g.description} | #{g.weight}x #{g.grade}"
    end
end