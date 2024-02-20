# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class ClassRoom
    # Returns a new instance of ClassRoom.
    # @param rawParsed [Hash] The raw data, yet it has already been parsed (like with JSON.parse)
    # @since 1.1.0
    def initialize(rawParsed)
      @name = rawParsed["Naam"]
    end

    # The name of the class
    # @return [String] name
    # @since 1.1.0
    def name
        @name
    end
end