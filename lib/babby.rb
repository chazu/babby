require "babby/version"

module Babby
  module MetaDSL
    def metaclass
      class << self
        self
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def dsl_method name, type: nil
        state_type = type ? STATE_TYPE_MAP[type] : nil

        if type == :array
          define_singleton_method name do |value| # define 'setter' for derived class - i.e. DSL 'setup' method a la attr_accessor
            if not self.instance_variable_get  "@#{name}"
              self.instance_variable_set "@#{name}", type ? state_type.new : nil
            end

            self.instance_variable_get("@#{name}").push(value)  # Set the underlying class instance variable to the desired value
          end
        else
          define_singleton_method name do |value| # define 'setter' for derived class - i.e. DSL 'setup' method a la attr_accessor
            if not self.instance_variable_get  "@#{name}"
              self.instance_variable_set "@#{name}", type ? state_type.new : nil
            end

            self.instance_variable_set "@#{name}", value  # Set the underlying class instance variable to the desired value
          end
        end
        define_singleton_method "get_#{name}".to_sym do
          self.instance_variable_get "@#{name}"
        end

        define_method name do
          self.class.send "get_#{name}".to_sym
        end
      end
    end
  end
end
