# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister/types/class.rb'
require 'date'
require 'json'

def validate_date(date)
    format = '%Y-%m-%d'
    DateTime.strptime(date, format)
    true
rescue ArgumentError
    false
end

module MagisterData
    def get_classes(dateFrom, dateTo)
        if validate_date(dateFrom) && validate_date(dateTo)
            data = @profile.authenticatedRequest("/personen/{*id*}/afspraken?status=1&van=#{dateFrom}&tot=#{dateTo}")
            classes = Array.new
            data["Items"].each do |classItem|
                classes.push MagClass.new(classItem)
            end
            classes
        else
            puts "Invalid date, Format is yyyy-mm-dd"
        end
    end

    def get_grades(count, page)
        @profile.authenticatedRequest("/personen/{*id*}/cijfers/laatste?top=#{count}&skip=#{count * page}")
    end
end