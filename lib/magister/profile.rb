# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'uri'
require 'net/http'
require 'json'

class Profile
  def initialize(token, school)
    @token = token
    @id = 0
    @school = school
  end

  def verify()
    if @school == nil || @token == nil
      puts "Either school or token was not defined!"
    end
    puts "authenticating to #{@school}..."
    uri = URI("https://#{@school}.magister.net/api/account?noCache=0")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request['authorization'] = "Bearer #{@token}"

    begin
      response = http.request(request)
      if response.is_a?(Net::HTTPSuccess)
        res = JSON.parse(response.body)
        person = res["Persoon"]
        puts "Succesfully authenticated as #{person["Roepnaam"]} with id #{person["Id"]}"
      else
        puts "Failed to authenticate, http code #{response.code}"
      end
    rescue StandardError => e
      puts "An error occurred #{e}"
    end
  end
end
