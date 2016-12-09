# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lucid_http/version'

Gem::Specification.new do |spec|
  spec.name          = "lucid_http"
  spec.version       = LucidHttp::VERSION
  spec.authors       = ["Federico Iachetti"]
  spec.email         = ["iachetti.federico@gmail.com"]

  spec.summary       = %q{Lucid Http wraps the http.rb gem in a simple DSL.}
  spec.description   = %q{Lucid Http wraps the http.rb gem in a simple DSL. Is particularly useful for screencasts and simple presentations.}
  spec.homepage      = "https://github.com/iachettifederico/lucid_http"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "http", "~> 2.1"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
