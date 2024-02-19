require "rake"

Gem::Specification.new do |s|
    s.name          = "magister"
    s.version       = "1.0.0"
    s.licenses      = ["MPL-2.0"]
    s.summary       = "Magister API wrapper"
    s.description   = "An unofficial Magister API wrapper for ruby"
    s.authors       = "Riley0122"
    s.email         = "contact@riley0122.dev"
    s.files         = FileList['lib/**/*.rb']
    s.bindir        = 'bin'
    s.homepage      = 'https://github.com/riley0122/rubymag#readme'
    s.metadata      = { "source_code_uri" => "https://github.com/riley0122/rubymag" }
    s.add_dependency "json"
    s.add_dependency "securerandom"
    s.add_dependency "base64"
end