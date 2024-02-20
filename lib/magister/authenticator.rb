# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister/profile'
require 'net/http'
require 'json'
require 'securerandom'
require 'base64'
require 'digest'
require 'selenium-webdriver'

module Authenticator
    extend self

    def login(username, password, school)
        # uri = URI("https://#{school}.magister.net/oidc_config.js")
        # http = Net::HTTP.new(uri.host, uri.port)
        # http.use_ssl = true
        # request = Net::HTTP::Get.new(uri.request_uri)
        # response = http.request(request)
        # oidc_conf = (response.body.split("config =").last.split("};").first.gsub("window.location.hostname", "'" + uri.hostname + "'") + "}").gsub(': ', '":').gsub(/,(\s*)/, ',"').gsub(/{(\s*)/, '{"').gsub("'", '"').gsub('" + "', "")

        # oidc_conf = JSON.parse(oidc_conf)

        codeVerifier  = SecureRandom.alphanumeric(128)
        verifier      = Base64.urlsafe_encode64(codeVerifier)

        rawChallenge = Digest::SHA256.hexdigest verifier
        challenge = Base64.urlsafe_encode64(rawChallenge)

        @@state = SecureRandom.hex(16)
        @@nonce = SecureRandom.hex(16)

        auth_uri = "https://#{school}.magister.net/connect/authorize?client_id=M6LOAPP&redirect_uri=m6loapp%3A%2F%2Foauth2redirect%2F&scope=openid%20profile%20opp.read%20opp.manage%20attendance.overview%20attendance.administration%20calendar.ical.user%20calendar.to-do.user%20grades.read%20grades.manage&state=#{@@state}&nonce=#{@@nonce}&code_challenge=#{challenge}&code_challenge_method=S256&prompt=select_account"
        # puts "using authentication url #{auth_uri}"

        if $authMode == "local"
            raise NotImplementedError.new("\n\nLocal authentication mode has not been implemented yet, \nCheck our github for any updates, or if you want to help implementing it!\n")
        else
            puts "Using Selenium with Chrome for authentication."
            options = Selenium::WebDriver::Options.chrome(args: ['--headless=new'])
            driver = Selenium::WebDriver.for :chrome, options: options

            driver.get auth_uri
            while !driver.current_url.start_with? "https://accounts.magister.net/account/login"
                sleep(0.5)
                # puts "waiting for load..."
            end
            sleep(3)

            username_field = driver.find_element(id: 'username')
            username_field.send_keys(username)
            go_to_password_button = driver.find_element(id: 'username_submit')
            go_to_password_button.click

            sleep(1)

            password_field = driver.find_element(id: 'password')
            password_field.send_keys(password)
            signin_button = driver.find_element(id: 'password_submit')
            signin_button.click

            wait = Selenium::WebDriver::Wait.new(timeout: 30)
            wait.until { driver.current_url.start_with? "https://#{school}.magister.net/oidc/redirect_callback.html" }

            token = driver.current_url.split("access_token=").last.split("&").first

            driver.quit

            return Profile.new(token, school)
        end
    end
end