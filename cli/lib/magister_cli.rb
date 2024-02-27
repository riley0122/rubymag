# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister'
require 'magister_cli/ext/string'

$magcli_runmode = "normal"

module MagisterCLI
    extend self

    def main
        if ARGV.include?("-r") || ARGV.include?("--run")
            $magcli_runmode = "inline"
            args = ARGV
            while args.include?("-r") do
              i = args.find_index("-r")
              args.delete_at(i)
            end

            while args.include?("--run") do
              i = args.find_index("--run")
              args.delete_at(i)
            end
            # TODO: tokenize command
            # TODO: parse command
            # TODO: run command
            return
        end

        # TODO: ask for command
        # TOOD: tokenize command
        # TODO: parse command
        # TODO: run command
    end
end
