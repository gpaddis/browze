# frozen_string_literal: true

require_relative 'lib/browze/version'

Gem::Specification.new do |spec|
  spec.name          = 'browze'
  spec.version       = Browze::VERSION
  spec.authors       = ['Gianpiero Addis']

  spec.summary       = 'A wrapper around HTTParty to quick start scraping tasks.'
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

  spec.add_dependency 'down'            # https://github.com/janko/down
  spec.add_dependency 'geocoder'        # https://github.com/alexreisner/geocoder
  spec.add_dependency 'httparty'        # https://github.com/jnunemaker/httparty
  spec.add_dependency 'nokogiri'        # https://github.com/sparklemotion/nokogiri
  spec.add_dependency 'tty-progressbar' # https://github.com/piotrmurach/tty-progressbar

  spec.add_development_dependency 'rspec-retry'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
