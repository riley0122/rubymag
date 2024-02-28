# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require "magister_cli"
require "json"

program = "login {school: 'rsgslingerbos', username: '2023520'}"
parser = Parser.new(program)
puts parser.parse