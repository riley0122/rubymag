# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class Subject
    # Returns a new instance of Subject.
    # @param rawParsed [Hash] The raw data, yet it has already been parsed (like with JSON.parse)
    # @since 1.1.0
    def initialize(rawParsed)
        @id = rawParsed["Id"]
        @name = rawParsed["Naam"]
    end

    # The id (or code) of the subject
    # @return [Integer, String] id
    # @note When initialized by +Grade+ it uses the code as the id to initialize
    # @see Grade
    # @since 1.1.0
    def id
        @id
    end
    # The name of the subject
    # @return [String] Name
    # @note When initialized by +Grade+ it uses the description as the name to initialize
    # @see Grade
    # @since 1.1.0
    def name
        @name
    end
end