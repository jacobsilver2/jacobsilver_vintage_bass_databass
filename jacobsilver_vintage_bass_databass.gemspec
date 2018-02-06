
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jacobsilver_vintage_bass_databass/version"

Gem::Specification.new do |spec|
  spec.name          = "jacobsilver_vintage_bass_databass"
  spec.version       = JacobsilverVintageBassDatabass::VERSION
  spec.authors       = ["jacobsilver2"]
  spec.email         = ["jacobsilver2@mac.com"]

  spec.summary       = %q{A Ruby gem which allows the user to explore some famous and sought after vintage electric basses}
  spec.description   = %q{This gem displays brands, models and years of 5 companies who have made basses throughout the years: Rickenbacker, Fender, Gibson, Ampeg, and Musicman.  It gets data from scraping http://vintagebassworld.com}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
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

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  
  spec.add_development_dependency "nokogiri"
end
