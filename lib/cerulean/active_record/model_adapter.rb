module Cerulean
  module ActiveRecord
    module ModelAdapter
      DEFAULT_CONFIGURATION_COLUMN = 'configuration'.freeze

      def self.included(base)
        base.extend ClassMethods
      end

      def cerulean_processor
        @cerulean_processor ||= Cerulean::ActiveRecord::Processor.new(self)
      end

      module ClassMethods
        def setting(key, parent: nil, config: {})
          setting = Cerulean::Engine.known_settings[key.to_sym]
          if config.present?
            setting = if setting.nil?
                        Cerulean::SettingConfiguration.new(key.to_sym, config)
                      else
                        Cerulean::SettingConfiguration.modify(setting, config)
                      end
          end
          raise Cerulean::UnknownConfig, "Unknown config #{key}" if setting.nil?

          define_cerulean_getter(setting, parent: parent)
          define_cerulean_setter(setting)
          apply_cerulean_validations(setting)
        end

        def cerulean_configuration_column
          @cerulean_configuration_column ||= DEFAULT_CONFIGURATION_COLUMN
        end

        def cerulean_configuration_column=(column_name)
          @cerulean_configuration_column = column_name.to_s
        end

        private ################################################################

        def define_cerulean_getter(setting, parent: nil)
          define_method(setting.name) do |mode = :none|
            cerulean_processor.fetch(setting, parent: parent, mode: mode)
          end

          if setting.type == :boolean
            define_method("#{setting.name}?") do |mode = :none|
              public_send(setting.name, mode)
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
          [setting.validations].flatten.each do |validation|
            validates setting.name, validation
          end
        end
      end
    end
  end
end
