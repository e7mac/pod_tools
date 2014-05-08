# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pod_tools/version'

Gem::Specification.new do |spec|
  spec.name          = "pod_tools"
  spec.version       = PodTools::VERSION
  spec.authors       = ["Kerem Karatal"]
  spec.email         = ["kkaratal@tidepool.co"]
  spec.description   = %q{Tools for managing cocoapods.}
  spec.summary       = %q{Tools to easily submit podspecs and also selectively choose what pod to be used in development mode locally.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "cocoapods"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "pry-stack_explorer"
  spec.add_development_dependency "pry-byebug", "~> 1.3"
end
