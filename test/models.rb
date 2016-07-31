class BasicModel < ActiveRecord::Base
  serialize :prefs
  include HasConfig::ActiveRecordModel
  self.config_column = :prefs

  has_config :favorite_color
  has_config :enable_email
  has_config :rate_limit
end

