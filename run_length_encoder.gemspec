
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "run_length_encoder/version"

Gem::Specification.new do |spec|
  spec.name          = "run_length_encoder"
  spec.version       = RunLengthEncoder::VERSION
  spec.authors       = ["Josh Bodah"]
  spec.email         = ["joshuabodah@gmail.com"]

  spec.summary       = %q{run-length encode/decode stuff}
  spec.homepage      = "https://github.com/jbodah/run_length_encoder"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
