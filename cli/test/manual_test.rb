# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require "magister_cli"
require "magister_cli/parser"
require "json"

@parser = Parser.new
program = "12"
ast = @parser.parse(program)
puts ast.to_json
