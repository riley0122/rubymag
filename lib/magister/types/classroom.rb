# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class ClassRoom
    def initialize(rawParsed)
      @name = rawParsed["Naam"]
    end

    # The name of the class
    # @returns [String] name
    # @since 1.1.0
    def name
        @name
    end
end