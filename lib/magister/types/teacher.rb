# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class Teacher
    # Returns a new instance of Teacher.
    # @param rawParsed [Hash] The raw data, yet it has already been parsed (like with JSON.parse)
    # @since 1.1.0
    def initialize(rawParsed)
        @id = rawParsed["Id"]
        @name = rawParsed["Naam"]
        @abrev = rawParsed["Docentcode"]
    end

    # The id of the teacher
    # @return [Integer] id
    # @since 1.1.0
    def id
        @id
    end
    # The name of the teacher
    # @return [String] name
    # @since 1.1.0
    def name
        @name
    end
    # The abreviation of the teacher
    # @return [String] Abreviation
    # @since 1.1.0
    def abrev
        @abrev
    end
    # The abreviation of the teacher
    # @return [String] Abreviation
    # @since 1.1.0
    def abreviaton
        @abrev
    end
    # The abreviation of the teacher
    # @return [String] Abreviation
    # @since 1.1.0
    def code
        @abrev
    end
end