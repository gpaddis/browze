# frozen_string_literal: true

require_relative 'lib/browze/version'

Gem::Specification.new do |spec|
  spec.name          = 'browze'
  spec.version       = Browze::VERSION
  spec.authors       = ['Gianpiero Addis']

  spec.summary       = 'A wrapper arount HTTParty to quick start scraping tasks.'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty'

  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
