# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require 'magister/profile'
require 'magister/data'
require 'magister/authenticator'

# can be either "selenium" or "local"
# "selenium" will run headlessly
# "local" will open a browser window for the user to login
$authMode = "selenium"

# Caching options
$magister_useCache = true
$magister_cachingDirectory = ".cache/magister"

prev = ""
$magister_cachingDirectory.split("/").each do |directory|
    Dir.mkdir(prev + directory) unless File.exist?(prev + directory)
    prev += directory + "/"
end

# Cache type can eitehr be "compact" or "json"
$magister_cacheType = "json"
# Wether to encrypt the cache, this can secure the acount by not exposing the token or any sensetive data.
$magister_encryptCache = false
# When using encryption, this may not be empty
$magister_encryptionKey = ""

# The main magister class
class Magister
    include MagisterData

    # Returns a new instance of Magister.
    # @since 1.0.0
    def initialize
        @profile = nil
    end

    # Create a new profile and authenticate with a token
    # @param school [String] The school the user attends
    # @param token [String] The users token
    # @since 1.0.0
    def authenticate(school, token)
        @profile = Profile.new(token, school)
        @profile.verify
    end
    # Create a new profile based on a username and password
    # @param school [String] The school the user attends
    # @param username [String] The users username
    # @param password [String] The users password
    # @see Authenticator#login
    # @since 1.1.0
    def login(school, username, password)
        @profile = Authenticator.login(username, password, school)
    end

    # Get the users profile
    # @return [Profile] the profile
    # @since 1.0.0
    def profile
        @profile
    end
end
