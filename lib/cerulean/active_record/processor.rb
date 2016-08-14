module Cerulean
  module ActiveRecord
    class Processor
      def initialize(model)
        @model = model
      end

      def fetch(setting, parent: nil, mode: :none)
        local = local_value(cerulean_column_data, setting)

        if parent && mode == :resolve && Cerulean::Chain.invoke?(local, setting.chain_on)
          parent_value = @model.public_send(parent).public_send(setting.name, :resolve)
          return parent_value unless parent_value.blank?
        end

        local
      end

      def set(setting, value)
        data          = cerulean_column_data
        parsed_value  = Cerulean::ValueParser.parse(value, setting.type)

        if data[setting.name] != parsed_value
          data[setting.name] = parsed_value
          @model.send(:write_attribute, cerulean_column, data)
          @model.public_send("#{cerulean_column}_will_change!")
        end
      end

      private ##################################################################

      def cerulean_column
        @model.class.cerulean_configuration_column
      end

      def cerulean_column_data
        @model.attributes[cerulean_column] || {}
      end

      def local_value(data, setting)
        if data[setting.name].nil?
          setting.default
        else
          data[setting.name]
        end
      end
    end
  end
end
