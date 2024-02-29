# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister'
require 'magister_cli/ext/string'
require 'magister_cli/parser'
require 'magister_cli/tokenizer'
require 'magister_cli/runtime'
require 'io/console'

$magister_cachingDirectory = Dir.home + "/.cache/magister"

$magcli_runmode = "normal"
$magcli_runtime_variables = {}

module MagisterCLI
    extend self

    def main
      $magcli_runtime_variables["magister"] = Magister.new

      begin
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

        parser = Parser.new("")
        while true
          print "> "
          input = gets.chomp
          parser.string = input
          output = parser.parse

          # loop over each action that was outputted
          output.each do |action|
            props = action["parameters"]
            doneParams = Array.new
            # get any parametres that werent set and ask then set them
            action["lacking_params"].each do |param|
              print "#{param}: "
              if param == "password"
                ans = STDIN.noecho(&:gets).chomp
                print "\n"
              else
                ans = gets.chomp
              end
              props.append({"type" => "PROPERTY", "key" => param, "value" => ans})
              doneParams.append param
            end

            # update lacking_params value, done here as to not mess with the order while looping over them
            doneParams.each do |p|
              action["lacking_params"].delete(p)
            end
            action["parameters"] = props
            props = Array.new

            runtime = Runtime.new(action)
          end
        end
      rescue SignalException
        $magcli_runtime_variables = Array.new
        puts "[CTRL + C]\nExiting..."
        exit
      rescue UncaughtThrowError => e
        if e.message.include? "#<SyntaxError: "
          message = e.message.split("#<SyntaxError: ").last[0..-2]
          puts "Invalid syntax: #{message}"
        else
          puts "Something went wrong: #{e.message}"
        end
      rescue => e
        puts "Something went wrong: #{e.message}"
      end
    end
end
