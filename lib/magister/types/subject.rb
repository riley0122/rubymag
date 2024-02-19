# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class Subject
    def initialize(rawParsed)
        @id = rawParsed["Id"]
        @name = rawParsed["Naam"]
    end

    # getters
    def id
        @id
    end
    def name
        @name
    end
end