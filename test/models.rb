class BasicModel < ActiveRecord::Base
  serialize :configuration
  include Cerulean::ActiveRecord::ModelAdapter

  cerulean_setting :string_setting
  cerulean_setting :boolean_setting
  cerulean_setting :integer_setting
end

class CustomColumnModel < ActiveRecord::Base
  serialize :prefs
  include Cerulean::ActiveRecord::ModelAdapter
  self.cerulean_configuration_column = :prefs

  cerulean_setting :string_setting
  cerulean_setting :boolean_setting
  cerulean_setting :integer_setting
end

class JsonColumnModel < ActiveRecord::Base
  include Cerulean::ActiveRecord::ModelAdapter

  cerulean_setting :string_setting
  cerulean_setting :boolean_setting
  cerulean_setting :integer_setting
end

class Client < ActiveRecord::Base
  has_many :groups
  include Cerulean::ActiveRecord::ModelAdapter
  cerulean_setting :chained_integer
end

class Group < ActiveRecord::Base
  belongs_to :client
  has_many :users
  include Cerulean::ActiveRecord::ModelAdapter
  cerulean_setting :chained_integer, parent: :client
end

class User < ActiveRecord::Base
  belongs_to :group
  include Cerulean::ActiveRecord::ModelAdapter
  cerulean_setting :chained_integer, parent: :group
end
