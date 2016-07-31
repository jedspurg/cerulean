class BasicModel < ActiveRecord::Base
  #serialize :prefs
  serialize :configuration
  include Cerulean::ActiveRecordModel
  #self.config_column = :prefs

  cerulean_config :string_setting
  cerulean_config :boolean_setting
  cerulean_config :integer_setting
end

