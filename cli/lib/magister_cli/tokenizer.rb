# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class Tokenizer
    @@spec = [
        [/^\d+/, "NUMBER"],
        [/^'[^']*'/, "STRING"],
        [/^"[^"]*"/, "STRING"],
        [/^\s+/, "WHITESPACE"]
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

            if item[1] == nil
                return get_next_token
            end

            if matched != nil
                @cursor += matched[0].length
                value = matched[0]

                if item[1] == "WHITESPACE"
                    # Get next token after whitespace
                    return self.get_next_token
                elsif item[1] == "STRING"
                    # Remove last character
                    value.delete_suffix!("'")
                    value.delete_suffix!('"')
                end

                return {"type" => item[1], "value" => value}
            end
        end

        throw SyntaxError.new "[tokenizer] Couldn't match"
    end
end