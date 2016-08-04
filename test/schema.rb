ActiveRecord::Schema.define do
  self.verbose = false

  create_table :basic_models, force: true do |t|
    t.text :configuration
  end

  create_table :custom_column_models, force: true do |t|
    t.text :prefs
  end

  create_table :json_column_models, force: true do |t|
    t.json :configuration
  end
end
