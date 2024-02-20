# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister/types/person'
require 'uri'
require 'net/http'
require 'json'

class Profile
  def initialize(token, school)
    @token = token
    @id = 0
    @school = school
    @person = nil
  end

  def token=(token)
    @token=token
  end
  def id
    @id
  end
  def school
    @school
  end
  def inspect
    "#<#{self.class}:0x#{object_id} @token=\"[PRIVATE]\", @id=#{@id}, @school=#{@school}>"
  end

  def person
    @person
  end

  def verify()
    if @school == nil || @token == nil
      puts "Either school or token was not defined!"
    end
    puts "authenticating to #{@school}..."
    uri = URI("https://#{@school}.magister.net/api/account")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request['authorization'] = "Bearer #{@token}"

    begin
      response = http.request(request)
      if response.is_a?(Net::HTTPSuccess)
        res = JSON.parse(response.body)
        @person = Person.new res["Persoon"]
        @id = @person.id.to_i
        puts "Succesfully authenticated as #{@person.firstName} with id #{@person.id}"
      else
        puts "Failed to authenticate, http code #{response.code}"
      end
    rescue StandardError => e
      puts "An error occurred #{e}"
    end
  end

  def authenticatedRequest(endpoint)
    if @id == 0
      puts "Not yet authenticated!"
      self.verify()
    end
    uri = URI("https://#{@school}.magister.net/api#{endpoint}".gsub("{*id*}", @id.to_s))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request['authorization'] = "Bearer #{@token}"

    begin
      response = http.request(request)
      if response.is_a?(Net::HTTPSuccess)
        return JSON.parse(response.body)
      else
        puts "failed to get #{endpoint}, status code #{response.code}"
        return nil
      end
    rescue StandardError => e
      puts "An error occurred #{e}"
    end
  end
end
