# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class Tokenizer
    @@spec = [
        [/(\w+)/, "KEYWORD"],
        [/(?:\w+\s?){(.*)}/, "PARAMS"],
        [/(?:\w+\s?(?:{.*}\s?)?)\[(.*)\]/, "OPTIONS"],
        [/(\s+)/, "EMPTY"]
    ]

    def initialize(string)
        @string = string
    end

    def parse_options(optionsString)
        cursor = 0
        found = Array.new
        while cursor < optionsString.length
            scope = optionsString[cursor..-1]

            if scope[0] == "{" || scope[0] == "}" || scope[0] == "[" || scope[0] == "]"
                cursor += 1
                next
            end

            whiteSpaceMatch = scope.match /^\s+/
            if whiteSpaceMatch != nil
                cursor += whiteSpaceMatch[0].length
                next
            end

            keywordMatch = scope.match /^\w+\s?:/
            if keywordMatch != nil
                cursor += keywordMatch[0].length
                found.append({"type" => "KEYWORD", "value" => keywordMatch[0][0..-2]})
                next
            end

            explicitString = scope.match /^'([^']*)',*/
            if explicitString != nil
                cursor += explicitString[0].length
                found.append({"type" => "STRING", "value" => explicitString.captures[0]})
                next
            end

            impliedString = scope.match /^(.*?),*/
            if impliedString != nil
                cursor += impliedString[0].length
                found.append({"type" => "STRING", "value" => impliedString.captures[0]})
                next
            end
        end
        parsed = Array.new
        i = 0
        while i < found.length
            if found[i]["type"] != "KEYWORD" || found[i + 1]["type"] != "STRING"
                throw TypeError.new "Expected #{found[i]["value"]} to be a KEYWORD and #{found[i + 1]["value"]} to be a STRING"
            end

            parsed.append({"type" => "PROPERTY", "key" => found[i]["value"], "value" => found[i + 1]["value"]})

            i += 2
        end
        parsed
    end

    def tokenize
        @tokens = Array.new
        @@spec.each do |item|
            matched = @string.match item[0]
            if matched != nil
                matched.captures.each do |match|
                    if item[1] == "PARAMS" || item[1] == "OPTIONS"
                        @tokens.append({"type" => item[1], "value" => parse_options(match)})
                    elsif item[1] == "EMPTY"
                    else
                        @tokens.append({"type" => item[1], "value" => match})
                    end
                end
            end
        end
        @tokens
    end
end