# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister'
require 'dotenv'

Dotenv.load('.env', 'magister.env')

$magister_disableHeadless = true

magister = Magister.new

magister.login(ENV["SCHOOL"], ENV["_USERNAME"], ENV["PASSWORD"])

grades = Array.new
magister.profile.authenticatedRequest("/personen/{*id*}/cijfers/laatste")["items"].each do |g|
    grades.push Grade.new(g)
end

# not selection sort at all trust me
grades.each_with_index do |grade, index|
    jMin = index

    j = index + 1
    while j < grades.length
        if grades[j].value < grades[jMin].value
            jMin = j
            next
        end
        j += 1
    end

    if jMin != index
        grades[index], grades[jMin] = grades[jMin], grades[index]
    end
end

grades.reject! {|grade| grade.value == 0}   # Remove any grade that werent a numerical grade (i.e. OVG grades)

puts "#{magister.profile.person.firstName}, your lowest grade this year was a #{grades[0].value} for #{grades[0].subject.name}"
