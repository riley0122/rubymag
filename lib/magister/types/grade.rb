# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'json'

class Grade
    def initialize(rawParsed)
        @id             = rawParsed["kolomId"]
        @description    = rawParsed["omschrijving"]
        # This is an attrocity and shouldnt exist. yet here it is.
        @subject        = Subject.new(JSON.parse("{\"Id\": \"#{rawParsed["vak"]["code"]}\", \"Naam\": \"#{rawParsed["vak"]["omschrijving"]}\"}"))

        @grade          = rawParsed["waarde"].gsub(",", ".").to_f
        @weight         = rawParsed["weegfactor"]

        @isSufficient   = rawParsed["isVoldoende"]
        @counts         = rawParsed["teltMee"]
        @toBeCaughtUp   = rawParsed["moetInhalen"]

        @isExempt       = rawParsed["heeftVrijstelling"]

        # addedOn is when the teacher added it to magister
        # earnedOn is when the test was done, most teachers dont put this in
        @addedOn        = rawParsed["ingevoerdOp"]
        @earnedOn       = rawParsed["behaaldOp"]
    end

    # The id of the grade
    # @return [Integer] id
    # @since 1.1.0
    def id
        @id
    end
    # The description of the grade
    # @return [String] description
    # @since 1.1.0
    def description
        @description
    end
    # The subject the grade belongs to
    # @return [Subject] subject
    # @since 1.1.0
    def subject
        @subject
    end
    # If the grade is considered sufficient
    # @return [Boolean] sufficient
    # @since 1.1.0
    def isSufficient
        @isSufficient
    end
    # If the grade is considered insufficient
    # @return [Boolean] insufficient
    # @note This is simply the inverse of +isSufficient+
    # @see isSufficient
    # @since 1.1.0
    def isInsufficient
        !@isSufficient
    end
    # Get the actual grade/value
    # @return [Float] grade
    # @since 1.1.0
    def grade
        @grade
    end
    # Get the actual grade/value
    # @return [Float] grade
    # @see grade
    # @since 1.1.0
    def value
        @grade
    end
    # Get the wight of the grade
    # @return [Integer] weight
    # @since 1.1.0
    def weight
        @weight
    end
    # If the grade actually counts
    # @return [Boolean] counts
    # @since 1.1.0
    def counts
        @counts
    end
    # If the test/thing that caused the grade needs to be caught up on
    # @return [Boolean] needs to be caught up
    # @since 1.1.0
    def toBeCaughtUp
        @toBeCaughtUp
    end
    # If the current user is exempt from the subject
    # @return [Boolean] exempt
    # @since 1.1.0
    def isExempt
        @isExempt
    end
    # If the current user is exempt from the subject
    # @return [Boolean] exempt
    # @see exempt
    # @since 1.1.0
    def exempt
        @isExempt
    end
    # When the grade was entered
    # @return [String] Date
    # @note This is when the teacher added the grade to magisters
    # @see earnedOn
    # @since 1.1.0
    def addedOn
        @addedOn
    end
    # If the current user is exempt from the subhect
    # @return [Boolean, nil] exempt
    # @note This is when the actual test occurred
    # @see addedOn
    # @since 1.1.0
    def earnedOn
        @earnedOn
    end
end