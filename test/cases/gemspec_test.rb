# frozen_string_literal: true

require "open3"
require "rbconfig"
require_relative "../test_helper"

module Mysql2Rgeo
  class GemspecTest < ActiveSupport::TestCase
    def test_loading_gemspec_does_not_define_active_record
      gemspec_path = File.expand_path("../../activerecord-mysql2rgeo-adapter.gemspec", __dir__)
      script = <<~RUBY
        require "rubygems"

        abort "ActiveRecord was already defined" if Object.const_defined?(:ActiveRecord, false)

        spec = Gem::Specification.load(ARGV.fetch(0))
        abort "gemspec did not load" unless spec
        abort "gemspec defined ActiveRecord" if Object.const_defined?(:ActiveRecord, false)

        puts spec.version
      RUBY

      stdout, stderr, status = Open3.capture3(RbConfig.ruby, "-e", script, gemspec_path)

      assert status.success?, stderr
      assert_equal ActiveRecord::ConnectionAdapters::Mysql2Rgeo::VERSION, stdout.strip
    end
  end
end
