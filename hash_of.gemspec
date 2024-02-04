# frozen_string_literal: true

require_relative "lib/hash_of/version"

Gem::Specification.new do |spec|
  spec.name = "hash_of"
  spec.version = HashOf::VERSION
  spec.authors = ["Aaron Rosenberg"]
  spec.email = ["aarongrosenberg@gmail.com"]

  spec.summary = "Syntactic sugar to create hashes of hashes or arrays and ability to make them recursive."
  spec.homepage = "https://github.com/agrberg/hash_of"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["changelog_uri"] = "https://github.com/agrberg/hash_of/blob/main/CHANGELOG.md"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
