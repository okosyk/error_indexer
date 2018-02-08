
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "error_indexer/version"

Gem::Specification.new do |spec|
  spec.name          = "error_indexer"
  spec.version       = ErrorIndexer::VERSION
  spec.authors       = ["Orest"]
  spec.email         = ["okosy@softserveinc.com"]

  spec.summary       = %q{index errors for has many assocaiation}
  spec.description   = %q{index errors for has many assocaiation}
  spec.homepage      = "https://github.com/okosyk/error_indexer"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://github.com/okosyk/error_indexer"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 4.2.8"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
