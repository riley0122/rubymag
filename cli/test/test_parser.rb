# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require "minitest/autorun"
require "magister_cli"
require "magister_cli/parser"
require "json"

class TestParser < Minitest::Test
    def setup
        @parser = Parser.new
    end

    def test_numeric_literal
        program = "42"
        ast = @parser.parse(program)
        assert_equal JSON.parse('{"type": "Program", "body": [{"type": "NumericLiteral", "value":42}]}'), ast
    end

    def test_string_literal
        program = "'apples'"
        ast = @parser.parse(program)
        assert_equal JSON.parse('{"type": "Program", "body": [{"type": "StringLiteral", "value":"apples"}]}'), ast
    end

    def test_whitespace
        program = "   '  apples  '   "
        ast = @parser.parse(program)
        assert_equal JSON.parse('{"type": "Program", "body": [{"type": "StringLiteral", "value":"  apples  "}]}'), ast
    end

    def test_whitespace_again
        program = "   12       "
        ast = @parser.parse(program)
        assert_equal JSON.parse('{"type": "Program", "body": [{"type": "NumericLiteral", "value":12}]}'), ast
    end
end