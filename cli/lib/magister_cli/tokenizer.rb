# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class Tokenizer
    def init(string)
        @string = string
        @cursor = 0
    end

    def hasMoreTokens
        @cursor < @string.length
    end

    def get_next_token
        if !hasMoreTokens
            return nil
        end

        string = @string[@cursor..-1]

        if string[0].is_integer?
          number = ''
          while string[@cursor] != nil && string[@cursor].is_integer?
            number += string[@cursor]
            @cursor += 1
          end

          {"type" => "NUMBER", "value" => number}
        end
    end
end