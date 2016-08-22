# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Brew_Finder/version'

 Gem::Specification.new do |spec|
   spec.name          = "Brew_Finder"
   spec.version       = BrewFinder::VERSION
   spec.authors       = ["Kathleen DaSilva"]
   spec.email         = ["kayjsmith@cox.net"]
   spec.summary       = "Search for breweries/brewpubs using the Beer Mapping Project API"
   spec.description   = "Search by city/state to find local breweries/brewpubs, also view rating information for indiviual locations."
   spec.homepage      = ""
   spec.license       = "MIT"

   spec.files         = `git ls-files -z`.split("\x0")
   spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
   spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
   spec.require_paths = ["lib"]

   spec.add_development_dependency "bundler", "~> 1.5"
   spec.add_development_dependency "rake"
   spec.add_dependency "nokogiri"
   spec.add_dependency "colorize"
 end
