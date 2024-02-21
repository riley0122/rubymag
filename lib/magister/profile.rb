# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister/types/person'
require 'uri'
require 'net/http'
require 'json'

# This represents a profile or a user in magister
class Profile
  # Returns a new instance of Profile.
  # @param token [String] the users token
  # @param school [String] the school the user attends
  # @since 1.1.0
  def initialize(token, school)
    @token = token
    @id = 0
    @school = school
    @person = nil
  end

  # Set the user token
  # @param token [String] new token
  # @since 1.1.0
  def token=(token)
    @token=token
  end
  # Get the user id
  # @return [Integer] id
  # @since 1.0.0
  def id
    @id
  end
  # What school the user attends
  # @return [String] name of the school
  # @since 1.0.0
  def school
    @school
  end
  # Get a summary of the object
  # @return [String] the summary
  # @since 1.0.0
  def inspect
    "#<#{self.class}:0x#{object_id} @token=\"[PRIVATE]\", @id=#{@id}, @school=#{@school}>"
  end

  # Get the person of the profile
  # @return [Person] the person
  # @since 1.0.0
  def person
    @person
  end

  # Verify the authenticity of the token and obtain user data
  # @note +token+ and +school+ of the #Profile must be defined
  # @since 1.0.0
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

  # Makes a request that is authenticated on the users behalve.
  # @param endpoint [String] the endpoint to request (starting with slash, excluding /api)
  # @note if you put +{*id*}+ in the endpoint, it will be replaced by the users actual id.
  # @return [Hash] the response given by the magister api.
  # @example make a request to +https://SCHOOL.magister.net/api/sessions/current+ to get information about the current session (+profile+ is an instance of +Profile+)
  #   sessionInfo = profile.authenticatedRequest("/sessions/current")
  # @since 1.0.0
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
