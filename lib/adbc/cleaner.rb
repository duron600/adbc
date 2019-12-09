module Adbc
  class Cleaner
    EXCLUDES_TABLES = %w[ar_internal_metadata schema_migrations]

    def initialize(connection)
      @connection = connection
    end

    def clean
      raise "Use in test environment please" unless Rails.env.test?
      (@connection.tables - EXCLUDES_TABLES).each do |table_name|
        @connection.truncate(table_name)
      end
    end
  end
end
