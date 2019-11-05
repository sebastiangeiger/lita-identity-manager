Gem::Specification.new do |spec|
  spec.name          = "lita-identity-manager"
  spec.version       = "0.1.1"
  spec.authors       = ["Sebastian Geiger"]
  spec.email         = ["sebastian.geiger@gmail.com"]
  spec.description   = "A lita plugin that lets you manage identities"
  spec.summary       = "With this plugin you can link users to their identity on external services"
  spec.homepage      = "https://github.com/sebastiangeiger/lita-identity-manager"
  spec.license       = "ISC"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
