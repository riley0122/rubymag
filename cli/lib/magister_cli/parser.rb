# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister_cli/tokenizer'

class Parser
    def initialize(string)
        @tokenizer = Tokenizer.new(string)
        @string = string
    end

    def parse()
        tokens = @tokenizer.tokenize

        i = 0

        ast = Array.new
        while i < tokens.length
            tmp = 0
            props = false
            opts = false
            altOpts = false # true if opts are in the place props would be
            if tokens[0 + i]["type"] != "KEYWORD"
                puts "Current index: #{i.to_s}"
                throw SyntaxError.new "Expected #{tokens[0 + i]["value"]} to be a KEYWORD, is a #{tokens[0 + i]["type"]}"
            end

            if tokens[1 + i] != nil && tokens[1 + i]["type"] == "PARAMS"
                tmp += 1
                props = true
            end

            if tokens[2 + i] != nil && tokens[2 + i]["type"] == "OPTIONS"
                tmp += 1
                opts = true
            end

            if tokens[1 + i] != nil && tokens[1 + i]["type"] == "OPTIONS"
                if opts || props
                    throw SyntaxError.new "Cant have type OPTIONS here, must be PARAMS"
                end
                opts = true
                altOpts = true
                tmp += 1
            end

            ast_node = {"action" => tokens[0 + i]["value"]}

            if props
                ast_node["parameters"] = tokens[1 + i]["value"]
            end

            if opts
                if altOpts
                    ast_node["options"] = tokens[1 + i]["value"]
                else
                    ast_node["options"] = tokens[2 + i]["value"]
                end
            end

            ast.append(ast_node)

            i += tmp + 1 # + 1 for the keyword itself
        end

        ast
    end
end