class BasicModel < ActiveRecord::Base
  serialize :configuration
  include Cerulean::ActiveRecordModel

  cerulean_config :string_setting
  cerulean_config :boolean_setting
  cerulean_config :integer_setting
end

class CustomColumnModel < ActiveRecord::Base
  serialize :prefs
  include Cerulean::ActiveRecordModel
  self.cerulean_configuration_column = :prefs

  cerulean_config :string_setting
  cerulean_config :boolean_setting
  cerulean_config :integer_setting
end
