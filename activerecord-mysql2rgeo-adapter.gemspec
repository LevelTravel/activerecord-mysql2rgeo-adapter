# frozen_string_literal: true

version_file = File.expand_path("lib/active_record/connection_adapters/mysql2rgeo/version.rb", __dir__)
version = File.read(version_file)[/VERSION = "([^"]+)"/, 1]
raise "Unable to read mysql2rgeo version from #{version_file}" unless version

Gem::Specification.new do |spec|
  spec.name = "activerecord-mysql2rgeo-adapter"
  spec.summary = "ActiveRecord adapter for MySQL, based on RGeo."
  spec.description =
    "ActiveRecord connection adapter for MySQL. It is based on the stock MySQL adapter, and adds " \
    "built-in support for the spatial extensions provided by MySQL. It uses the RGeo library to represent " \
    "spatial data in Ruby. This gem is maintained for MySQL 8.0 and 8.4."

  spec.version = version
  spec.author = "Yongdae Hwang"
  spec.email = "stadia@gmail.com"
  spec.homepage = "http://github.com/stadia/activerecord-mysql2rgeo-adapter"
  spec.license = "BSD-3-Clause"

  spec.files = Dir["lib/**/*", "LICENSE.txt"]
  spec.platform = Gem::Platform::RUBY

  spec.required_ruby_version = ">= 3.2.0"

  spec.add_dependency "activerecord", ">= 7.2", "< 8.2"
  spec.add_dependency "rgeo-activerecord", ">= 8.0", "< 8.2"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.4"
  spec.add_development_dependency "minitest-excludes", "~> 2.0"
  spec.add_development_dependency "benchmark-ips", "~> 2.12"
  spec.add_development_dependency "rubocop", "~> 1.50"

  spec.metadata = {
    "funding_uri" => "https://opencollective.com/rgeo",
    "source_code_uri" => "https://github.com/stadia/activerecord-mysql2rgeo-adapter",
    "documentation_uri" => "https://github.com/stadia/activerecord-mysql2rgeo-adapter/blob/main/README.md",
    "rubygems_mfa_required" => "true"
  }
end
