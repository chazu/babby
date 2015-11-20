require "babby/version"

STATE_TYPE_MAP = {
  array: Array
}

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

      def apply_to entity_method_name
        # Set the name of the method to retrieve the entity bound to the instance, as a symbol
      end

      def dsl_method name, type: nil
        state_type = type ? STATE_TYPE_MAP[type] : nil

        if type == :array
          define_singleton_method name do |value| # define 'setter' for derived class - i.e. DSL 'setup' method a la attr_accessor
            if not self.instance_variable_get "@#{name}"
              self.instance_variable_set "@#{name}", state_type ? state_type.new : nil
            end

            self.instance_variable_get("@#{name}").push(value)  # Set the underlying class instance variable to the desired value
          end
        else
          define_singleton_method name do |value| # define 'setter' for derived class - i.e. DSL 'setup' method a la attr_accessor
            if not self.instance_variable_get  "@#{name}"
              self.instance_variable_set "@#{name}", state_type ? state_type.new : nil
            end

            self.instance_variable_set "@#{name}", value  # Set the underlying class instance variable to the desired value
          end
        end

        define_singleton_method "get_#{name}".to_sym do
          self.instance_variable_get "@#{name}"
        end

        if type == :proc
          define_method name do
            proc = self.class.send "get_#{name}".to_sym
            proc.call(entity)
          end
        else
          define_method name do
            self.class.send "get_#{name}".to_sym
          end
        end
      end
    end
  end
end              

