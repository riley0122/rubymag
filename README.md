# rubymag
[![License: MPL 2.0](https://img.shields.io/badge/License-MPL_2.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)

[![Ruby Gem](https://github.com/riley0122/rubymag/actions/workflows/gem-push.yml/badge.svg)](https://github.com/riley0122/rubymag/pkgs/rubygems/magister)
[![Gem Version](https://badge.fury.io/rb/magister.svg)](https://rubygems.org/gems/magister)

A pretty generic wrapper for the magister, specifically magister 6, api.

# Basic usage

You can simply create a new instance of the magister class.

```ruby
require 'magister'

magister = Magister.new
```

Then you can log the user with their school, username, and password.
```ruby
magister.login("someSchool", "123456", "p@s5W0rd!")
```

After wich you have to verify their identity in order to obtain user data such as their id.
```ruby
magister.profile.verify
```

Then the user is logged in and you can get the user data!
```ruby
puts "Welcome #{magister.profile.person["Roepnaam"]} #{magister.profile.person["Achternaam"]}!"
puts "You have succesfully logged in to #{magister.profile.school}."
```

For more in depth documentation, [see the wiki](https://github.com/riley0122/rubymag/wiki)
