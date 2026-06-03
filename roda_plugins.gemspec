require_relative "lib/roda_plugins/version"

Gem::Specification.new { |spec|
  spec.name = "roda_plugins"
  spec.version = RodaPlugins::VERSION
  spec.authors = ["Wenoa Studio"]
  spec.email = ["desarrollo@wenoa.studio"]

  spec.summary = "Roda plugins shared across Wenoa applications."
  spec.description = spec.summary
  spec.homepage = "https://github.com/wenoa/roda-plugins"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4"

  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir["lib/**/*.rb", "README.md", "LICENSE"]
  spec.require_paths = ["lib"]

  spec.add_dependency "roda", ">= 3.0"
}
