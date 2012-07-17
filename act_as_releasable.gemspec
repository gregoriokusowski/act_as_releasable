# -*- encoding: utf-8 -*-
require File.expand_path('../lib/act_as_releasable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Gregório Kusowski"]
  gem.email         = ["gregorio.kusowski@gmail.com"]
  gem.description   = %q{Make your models work with a release candidate that must be approved}
  gem.summary       = %q{wip}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "act_as_releasable"
  gem.require_paths = ["lib"]
  gem.version       = ActAsReleasable::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "factory_girl"
  gem.add_development_dependency "sqlite3"
  gem.add_dependency "activesupport"
  gem.add_dependency "activemodel"
  gem.add_dependency "activerecord"
end
