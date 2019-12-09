# Another Database Cleaner

require 'adbc/cleaner'

module Adbc

  class << self

    def cleaners
      @cleaners ||= [Adbc::Cleaner.new(ActiveRecord::Base.connection)]
    end

    def create_cleaner(connection)
      cleaners << Adbc::Cleaner.new(connection)
    end

    def clean
      cleaners.each &:clean
    end

    def watching
      yield
    ensure
      clean
    end

  end

end
