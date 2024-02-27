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
        puts ast.to_json
        assert_equal JSON.parse('{"type": "Program", "body": {"type": "NumericLiteral", "value":42}}'), ast
    end
end