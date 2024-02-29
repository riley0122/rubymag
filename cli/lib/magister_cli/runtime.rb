# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister'

def zulu_to_ams(string)
    ("%02d" % (string[0..1].to_i + 1)).to_s + string[2..-1]
end

module Runners
    def login(username, password, school)
        $magcli_runtime_variables["magister"].login(school, username, password)
    end

    def auth(token, school)
        $magcli_runtime_variables["magister"].authenticate(school, token)
    end

    def get_classes(date_from, date_to)
        classes = $magcli_runtime_variables["magister"].get_classes(date_from, date_to)
        if classes == nil
            raise "Couldn't fetch classes!"
        end
        if @opts["outputMode"]
            classes.each do |c|
                puts "|#{zulu_to_ams c.classStart.to_s[11..-13]} - #{zulu_to_ams c.classEndInclusive.to_s[11..-13]}| #{c.description} [#{c.location}]"
            end
        else
            puts classes.to_json
        end
    end
end

class Runtime
    include Runners

    @@spec = {
        "login" => :login,
        "auth" => :auth,
        "quit" => :exit,
        "exit" => :exit,
        "get_classes" => :get_classes
    }
    def initialize(action)
        if action["options"] != nil
            @opts = action["options"]
        else
            @opts = {"outputMode" => "formatted"}
        end

        if @opts["noCache"] != nil && @opts["noCache"] == "true"
            $magister_useCache = false
        else
            $magister_useCache = true
        end

        requiredArgs = Parser.new("").get_args(action["action"])
        args = Array.new

        if action["parameters"] == nil
            raise "Not a single parameter defined!! not even an empty array!"
        end

        requiredArgs.each do |arg|
            action["parameters"].each do |param|
                if arg == param["key"]
                    args.append(param["value"])
                end
            end
        end
        send(@@spec[action["action"]], *args)
    end
end