# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister/types/class'
require 'magister/types/grade'
require 'date'
require 'json'

# Validates a date
# @param date [String]
# @return [Boolean]
# @see get_classes
def validate_date(date)
    format = '%Y-%m-%d'
    DateTime.strptime(date, format)
    true
rescue ArgumentError
    false
end

# Functions for getting or setting data from/to the magister apis
module MagisterData
    # Get all the scheduled classes between 2 dates
    # @param dateFrom [String] the start of the selection
    # @param dateTo [String] the end of the selection
    # @since 1.0.0
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

    # Get a certain ammount of grades.
    # @param count [String] The ammount of grades to get
    # @param page [String] What page to get from
    # @since 1.1.0
    def get_grades(count = 5, page = 0)
        data = @profile.authenticatedRequest("/personen/{*id*}/cijfers/laatste?top=#{count}&skip=#{count * page}")
        grades = Array.new
        data["items"].each do |grade|
            grades.push Grade.new(grade)
        end
        grades
    end
end