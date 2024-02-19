# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require './lib/magister/profile.rb'
require 'net/http'
require 'json'
require 'securerandom'
require 'base64'
require 'digest'

module Authenticator
    def login(username, password, school)
        uri = URI("https://#{school}.magister.net/oidc_config.js")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)
        oidc_conf = (response.body.split("config =").last.split("};").first.gsub("window.location.hostname", "'" + uri.hostname + "'") + "}").gsub(': ', '":').gsub(/,(\s*)/, ',"').gsub(/{(\s*)/, '{"').gsub("'", '"').gsub('" + "', "")

        authority       = oidc_conf["authority"]
        clientId        = "M6LOAPP"
        #                  m6loapp://oath2redirect/
        redirctUri      = "m6loapp%3A%2F%2Foath2redirect%2F"
        scope           = oidc_conf["scope"].gsub(" ", "%20")
        responseType    = oidc_conf["response_type"].gsub(" ", "%20")

        codeVerifier  = SecureRandom.alphanumeric(128)
        verifier      = Base64.urlsafe_encode64(codeVerifier)

        rawChallenge = Digest::SHA256.hexdigest verifier
        challenge = Base64.urlsafe_encode64(rawChallenge)

        codeChallengeMethod = "S256"
        prompt = "select_account"

        @@state = SecureRandom.hex(16)
        @@nonce = SecureRandom.hex(16)

        if $authMode == "local"
            raise NotImplementedError.new("\n\nLocal authentication mode has not been implemented yet, \nCheck our github for any updates, or if you want to help implementing it!\n")
        else
            auth_uri = URI("#{authority}/connect/authorize?client_id=#{clientId}&redirect_uri=#{redirctUri}&scope=#{scope}&response_type=#{responseType}&state=#{@@state}&nonce=#{@@nonce}&code_challenge=#{challenge}&code_challenge_method=#{codeChallengeMethod}&prompt=#{prompt}")
        end
    end
end