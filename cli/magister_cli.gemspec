require "rake"

Gem::Specification.new do |s|
    s.name          = "magister_cli"
    s.version       = "1.1.2"
    s.licenses      = ["MPL-2.0"]
    s.summary       = "Cli for the magister API wrapper"
    s.description   = "The CLI for the 'magister' gem"
    s.authors       = "Riley0122"
    s.email         = "contact@riley0122.dev"
    s.files         =  FileList['lib/**/*.rb'] + FileList['bin/**/*']
    s.require_path  = 'lib'
    s.bindir        = 'bin'
    s.executables   = ['magister']
    s.homepage      = 'https://github.com/riley0122/rubymag/tree/main/cli#readme'
    s.metadata      = { "source_code_uri" => "https://github.com/riley0122/rubymag/tree/main/cli" }
    s.add_dependency "json"
    s.add_dependency "magister"
end
