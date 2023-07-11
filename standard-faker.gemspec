# frozen_string_literal: true

require_relative "lib/standard/faker/version"

Gem::Specification.new do |spec|
  spec.name = "standard-faker"
  spec.version = Standard::Faker::VERSION
  spec.authors = ["shilin-anton"]
  spec.email = ["anton.d.shilin@gmail.com"]

  spec.summary = "A Standard plugin that adds rubocop-faker specific rules to Standard."
  spec.homepage = "https://github.com/shilin-anton/standard-faker"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.metadata["default_lint_roller_plugin"] = "Standard::Faker::Plugin"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "lint_roller", "~> 1.0"
  spec.add_dependency "rubocop-faker", "~> 1.1.0"
end
