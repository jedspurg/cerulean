class BasicModel < ActiveRecord::Base
  serialize :configuration
  include Cerulean::ActiveRecord::ModelAdapter

  setting :string_setting
  setting :boolean_setting
  setting :integer_setting

  def bad_parent_method
    nil
  end
end

class ManualSettingModel < ActiveRecord::Base
  self.table_name = 'basic_models'
  serialize :configuration
  include Cerulean::ActiveRecord::ModelAdapter

  setting :string_setting, config: { default: 'custom' }
  setting :manual_setting, config: { type: :string, default: 'manual' }
end

class WithValidationModel < ActiveRecord::Base
  self.table_name = 'basic_models'
  serialize :configuration
  include Cerulean::ActiveRecord::ModelAdapter

  setting :string_setting, config: { type: :string, validations: { presence: true } }
end

class CustomColumnModel < ActiveRecord::Base
  serialize :prefs
  include Cerulean::ActiveRecord::ModelAdapter
  self.cerulean_configuration_column = :prefs

  setting :string_setting
  setting :boolean_setting
  setting :integer_setting
end

class JsonColumnModel < ActiveRecord::Base
  include Cerulean::ActiveRecord::ModelAdapter

  setting :string_setting
  setting :boolean_setting
  setting :integer_setting
end

class JsonbColumnModel < ActiveRecord::Base
  include Cerulean::ActiveRecord::ModelAdapter

  setting :string_setting
  setting :boolean_setting
  setting :integer_setting
end

class Client < ActiveRecord::Base
  has_many :groups
  include Cerulean::ActiveRecord::ModelAdapter
  setting :chained_integer
end

class Group < ActiveRecord::Base
  belongs_to :client
  has_many :users
  include Cerulean::ActiveRecord::ModelAdapter
  setting :chained_integer, parent: :client
end

class User < ActiveRecord::Base
  belongs_to :group
  include Cerulean::ActiveRecord::ModelAdapter
  setting :chained_integer, parent: :group
end

class ParentModel < ActiveRecord::Base
  serialize :configuration
  include Cerulean::ActiveRecord::ModelAdapter

  setting :string_setting
  setting :boolean_setting
  setting :integer_setting
end

class ChildModel < ParentModel
end
