require "rake"

Gem::Specification.new do |s|
    s.name          = "magister"
    s.version       = "1.3.1s"
    s.licenses      = ["MPL-2.0"]
    s.summary       = "Magister API wrapper"
    s.description   = "An unofficial Magister API wrapper for ruby"
    s.authors       = "Riley0122"
    s.email         = "contact@riley0122.dev"
    s.files         = FileList['lib/**/*.rb']
    s.require_path  = 'lib'
    s.bindir        = 'bin'
    s.homepage      = 'https://github.com/riley0122/rubymag#readme'
    s.metadata      = { "source_code_uri" => "https://github.com/riley0122/rubymag", "documentation_uri" => "https://riley0122.github.io/rubymag" }
    s.add_dependency "json", '~> 2.7', '>= 2.7.1'
    s.add_dependency "securerandom", '~> 0.3.1'
    s.add_dependency "base64", '~> 0.2.0'
    s.add_dependency "selenium-webdriver", '~> 4.17'
    s.add_dependency "magister_cli"
end
