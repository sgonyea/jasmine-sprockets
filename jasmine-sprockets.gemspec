# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jasmine-sprockets/version"

Gem::Specification.new do |s|
  s.name        = "jasmine-sprockets"
  s.version     = Jasmine::Sprockets::VERSION
  s.authors     = ["Scott Gonyea"]
  s.email       = ["sgonyea@truecar.com"]
  s.homepage    = ""
  s.summary     = %q{Adds Sprockets to Jasmine's Asset Serving}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "jasmine",   '~>1.0.2.1'
  s.add_runtime_dependency "sprockets", '~>2.0.0'
  s.add_runtime_dependency "rack",      '~>1.3.0'
end
