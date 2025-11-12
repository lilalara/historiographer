require "singleton"

module Historiographer
  class Configuration
    include Singleton

    OPTS = {
      mode: {
        default: :histories
      },
      user_method: {
        default: nil
      },
      user_class: {
        default: 'User'
      },
      ignored_attr: {
        default: []
      },
      store_indirect_update: { # Store history with update_columns
        default: true
      },
      store_destroyed_record: { # Saves if a record was originally destroyed
        default: false
      }
    }
    OPTS.each do |key, options|
      attr_accessor key
    end

    class << self
      def configure
        yield instance
      end

      OPTS.each do |key, options|
        define_method "#{key}=" do |value|
          instance.send("#{key}=", value)
        end

        define_method key do
          instance.send(key).nil? ? options.dig(:default) : instance.send(key)
        end
      end
    end

    def initialize
      @mode = :histories
    end
  end
end
