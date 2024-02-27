# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class Tokenizer
    @@spec = [
        [/^\d+/, "NUMBER"],
        [/^'[^']*'/, "STRING"],
        [/^"[^"]*"/, "STRING"],
    ]

    def init(string)
        @string = string
        @cursor = 0
    end

    def hasMoreTokens
        @cursor < @string.length
    end

    def isEOF?
        @cursor == @string.length
    end

    def get_next_token
        if !hasMoreTokens
            return nil
        end

        string = @string[@cursor..-1]

        @@spec.each do |item|
            matched = string.match item[0]
            if matched != nil
                @cursor += matched[0].length
                return {"type" => item[1], "value" => matched[0]}
            end
        end

        throw SyntaxError.new "[tokenizer] Couldn't match"
    end
end