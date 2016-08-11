# # coding: utf-8
# lib = File.expand_path('../lib', __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# require 'my_gem/version'

 Gem::Specification.new do |spec|
   spec.name          = "my_gem"
   spec.version       = MyGem::VERSION
   spec.authors       = ["Maintainer Name"]
   spec.email         = ["maintainer@email.address"]
   spec.summary       = "Search for breweries/brewpubs using the Beer Mapping Project API"
   spec.description   = %q{TODO: Write a longer description. Optional.}
   spec.homepage      = ""
   spec.license       = "MIT"

   spec.files         = `git ls-files -z`.split("\x0")
   spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
   spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
   spec.require_paths = ["lib"]

   spec.add_development_dependency "bundler", "~> 1.5"
   spec.add_development_dependency "rake"
 end
 mba:Git
