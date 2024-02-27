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
      "body" => literal
    }
  end

  def eat(token_type)
    token = @lookahead

    if token == nil
      throw SyntaxError.new "Unexpected end of input, expected type #{token_type}"
    end

    if token["type"] != token_type
      throw SyntaxError.new "Unexpected token #{token["value"]}, expected #{token_type}"
    end

    @lookahead = @tokenizer.get_next_token

    token
  end

  def literal
    case @lookahead["type"]
    when "NUMBER"
      numeric_literal
    when "STRING"
      string_literal
    else
      throw SyntaxError.new "That is not a valid literal type"
    end
  end

  def string_literal
    token = eat("STRING")
    {"type" => "StringLiteral", "value" => token["value"][1..-1]}
  end

  def numeric_literal
    token = eat("NUMBER")
    {"type" => "NumericLiteral", "value" => token["value"].to_i}
  end
end
