# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister_cli/tokenizer'

class Parser
  def initialize
    @string = ''
    @tokenizer = Tokenizer.new
  end

  def parse(string)
    @string = string
    @tokenizer.init(@string)

    @lookahead = @tokenizer.get_next_token

    program
  end

  def program
    {
      "type" => "Program",
      "body" => numeric_literal
    }
  end

  def eat(token_type)
    token = @lookahead

    if token == nil
      throw SyntaxError("Unexpected end of input, expected type #{token_type}")
    end

    if token["type"] != token_type
      throw SyntaxError("Unexpected token #{token.value}, expected #{token_type}")
    end

    @lookahead = @tokenizer.get_next_token

    token
  end

  def numeric_literal()
    token = eat("NUMBER")
    {"type" => "NumericLiteral", "value" => token["value"]}
  end
end
