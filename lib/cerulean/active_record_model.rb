module Cerulean
  module ActiveRecordModel
    def self.included(base)
      base.extend ClassMethods
    end

    def cerulean_processor
      @cerulean_processor ||= Cerulean::ActiveRecordProcessor.new(self)
    end

    module ClassMethods
      def cerulean_config(key, parent: nil)
        setting = Cerulean::Engine.known_settings[key.to_sym]
        raise Cerulean::UnknownConfig, "No setting found for #{key}" if setting.nil?

        define_cerulean_getter(setting, parent: parent)
        define_cerulean_setter(setting)
        apply_cerulean_validations(setting)
      end

      def cerulean_configuration_column
        @cerulean_configuration_column ||= 'configuration'
      end

      def cerulean_configuraion_column=(column_name)
        @cerulean_configuration_column = column_name.to_s
      end

      private ##################################################################

      def define_cerulean_getter(setting, parent: nil)
        define_method(setting.name) do |mode = :none|
          cerulean_processor.fetch(setting, parent: parent, mode: mode)
        end

        if setting.type == :boolean
          define_method("#{setting.name}?") do |mode = :none|
            public_send(name, mode)
          end
        end
      end

      def define_cerulean_setter(setting)
        define_method("#{setting.name}=") do |value|
          cerulean_processor.set(setting, value)
          value
        end
      end

      def apply_cerulean_validations(setting)
        setting.validations.each do |validation|
          validates setting.name, validation
        end
      end
    end
  end
end
