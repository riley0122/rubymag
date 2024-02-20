# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

module Birth
    def day
        @birthDay
    end
    def lastName
        @birthLastName
    end
    def preposition
        @birthnamePreposition
    end
    def use
        @useBirthname
    end
    def useBirthname
        @useBirthname
    end
end

module Official
    def firstNames
        @officialFirstNames
    end
    def prepositions
        @officialPrepositions
    end
    def lastName
        @officialLastName
    end
    def initials
        @initials
    end
end

class Person
    include Birth
    include Official

    def initialize(rawParsed)
        @id                     = rawParsed["Id"]
        @firstName              = rawParsed["Roepnaam"]
        @preposition            = rawParsed["Tussenvoegsel"]
        @lastName               = rawParsed["Achternaam"]
        @officialFirstNames     = rawParsed["OfficieleVoornamen"]
        @initials               = rawParsed["Voorletters"]
        @officialPrepositions   = rawParsed["OfficieleTussenvoegsels"]
        @officialLastName       = rawParsed["OfficieleAchternaam"]
        @birthDay               = rawParsed["Geboortedatum"]
        @birthLastName          = rawParsed["GeboorteAchternaam"]
        @birthnamePreposition   = rawParsed["GeboortenaamTussenvoegsel"]
        @useBirthname           = rawParsed["GebruikGeboortenaam"]

        # probably only for tracking
        @externalId             = rawParsed["ExterneId"]
    end

    # getters
    def id
        @id
    end
    def firstName
        @firstName
    end
    def preposition
        @preposition
    end
    def lastName
        @lastName
    end
    def initials
        @initials
    end
    def birthDay
        @birthDay
    end
    def useBirthname
        @useBirthname
    end
end