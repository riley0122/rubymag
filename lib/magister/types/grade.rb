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

    # getters
    def id
        @id
    end
    def description
        @description
    end
    def subject
        @subject
    end
    def isSufficient
        @isSufficient
    end
    def isInsufficient
        !@isSufficient
    end
    def grade
        @grade
    end
    def value
        @grade
    end
    def weight
        @weight
    end
    def counts
        @counts
    end
    def toBeCaughtUp
        @toBeCaughtUp
    end
    def isExempt
        @isExempt
    end
    def exempt
        @isExempt
    end
    def addedOn
        @addedOn
    end
    def earnedOn
        @earnedOn
    end
end