# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "safe_nested_calls/version"

Gem::Specification.new do |s|
  s.name        = "safe_nested_calls"
  s.version     = SafeNestedCalls::VERSION
  s.authors     = ["Rick Button"]
  s.email       = ["rickb@extemprep.com"]
  s.homepage    = ""
  s.summary     = %q{Safely call nested methods in Ruby}
  s.description = %q{Allows you to safely call nested methods on an object, returning nil if they are undefined. }

  s.rubyforge_project = "safe_nested_calls"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"

  s.add_development_dependency "rspec"
end
