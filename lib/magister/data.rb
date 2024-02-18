# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'date'

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
            @profile.authenticatedRequest("/personen/{*id*}/afspraken?status=1&van=#{dateFrom}&tot=#{dateTo}")
        else
            puts "Invalid date, Format is yyyy-mm-dd"
        end
    end
end