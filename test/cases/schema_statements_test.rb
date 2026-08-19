# frozen_string_literal: true

require_relative "../test_helper"

module Mysql2Rgeo
  class SchemaStatementsTest < ActiveSupport::TestCase
    def test_initialize_type_map
      SpatialModel.with_connection do |connection|
        connection.connect!
        type_map = connection.send(:type_map)
        initialized_types = type_map.keys

        # Keep mysql2rgeo-specific spatial aliases ahead of generic mappings.
        assert_equal initialized_types.first(9), %w[
          geography
          geometry
          geometry_collection
          line_string
          multi_line_string
          multi_point
          multi_polygon
          st_point
          st_polygon
        ]
        assert_instance_of ActiveRecord::Type::Spatial, type_map.lookup("geometry")
      end
    end

    def test_native_database_types_include_spatial_and_base_types
      SpatialModel.with_connection do |connection|
        native_types = connection.native_database_types

        assert native_types.key?(:string)
        assert_equal({ name: "geometry" }, native_types.fetch(:geometry))
        assert_equal({ name: "point" }, native_types.fetch(:st_point))
      end
    end
  end
end
