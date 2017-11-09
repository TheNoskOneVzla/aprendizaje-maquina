
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#$: << 'lib'
require "aprendizaje_maquina/version"

Gem::Specification.new do |spec|
  spec.name          = "aprendizaje_maquina"
  spec.version       = AprendizajeMaquina::VERSION
  spec.author       = "Erickson Morales"
  spec.email         = ["erickson_19_07@hotmail.com"]

  spec.summary       = "Machine learning gem / Una gema para el aprendizaje de maquinas."
  spec.description   = "This is a gem to help ruby developers to write machine learning algorithms easier and faster / Esta es una gema para ayudar a los desarrolladores de ruby a escribir algoritmos de aprendizaje automático más fácil y rápido."
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

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
