ActiveRecord::Schema.define do
  self.verbose = false

  create_table :basic_models, force: true do |t|
    t.text :configuration
  end
end
