# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Module used in the #person class
# @since 1.2.0
module Birth
    # The birthday of the person
    # @return [String] birthday
    # @since 1.2.0
    def day
        @birthDay
    end
    # The persons last name given at birth
    # @return [String] name
    # @since 1.2.0
    def lastName
        @birthLastName
    end
    # The persons preposition given at birth
    # @return [String] preposition
    # @since 1.2.0
    def preposition
        @birthnamePreposition
    end
    # Wether or not to use the users birth name
    # @return [Boolean] use birth name
    # @since 1.2.0
    def use
        @useBirthname
    end
    # Wether or not to use the users birth name
    # @return [Boolean] use birth name
    # @since 1.2.0
    def useBirthname
        @useBirthname
    end
end

# Module used in the #person class
# @since 1.2.0
module Official
    # The official first of the person
    # @return [String] name
    # @since 1.2.0
    def firstNames
        @officialFirstNames
    end
    # The official prepositions of the person
    # @return [String, nil] prepositions
    # @since 1.2.0
    def prepositions
        @officialPrepositions
    end
    # The official last name of the person
    # @return [String] name
    # @since 1.2.0
    def lastName
        @officialLastName
    end
    # The initials of the person
    # @return [String] initials
    # @since 1.2.0
    def initials
        @initials
    end
end

# This class describes the person object the magister api gives us
# this object includes all the user's personal data like name and birthday
class Person
    include Birth
    include Official

    # Returns a new instance of Person.
    # @param rawParsed [Hash] The raw data, yet it has already been parsed (like with JSON.parse)
    # @since 1.2.0
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

    # The id of the person
    # @return [Integer] id
    # @since 1.2.0
    def id
        @id
    end
    # The first name of the person
    # @return [String] name
    # @since 1.2.0
    def firstName
        @firstName
    end
    # The preposition (thing between first & last name) of the person
    # @return [String, nil] preposition
    # @since 1.2.0
    def preposition
        @preposition
    end
    # The last name of the person
    # @return [String] name
    # @since 1.2.0
    def lastName
        @lastName
    end
    # The initials of the person
    # @return [String] initials
    # @since 1.2.0
    def initials
        @initials
    end
    # The birthday of the person
    # @return [String] birthday
    # @since 1.2.0
    def birthDay
        @birthDay
    end
    # Wether or not to use the users birth name
    # @return [Boolean] use birth name
    # @since 1.2.0
    def useBirthname
        @useBirthname
    end
end