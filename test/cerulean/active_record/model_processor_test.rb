require 'test_helper'

class Cerulean::ActiveRecord::ProcessorTest < Minitest::Test
  Cerulean::Engine.load(path: File.expand_path("../../../config/cerulean_settings.rb", __FILE__))
  require 'schema'
  require 'models'

  def test_chaining_on_parent_that_does_not_exist_raises_an_error
    setting = Cerulean::SettingConfiguration.new(:bad_chain, type: :string)
    model = BasicModel.new
    processor = Cerulean::ActiveRecord::Processor.new(model)
    assert_raises Cerulean::InvalidChain do
      processor.fetch(setting, parent: :not_a_parent, mode: :resolve)
    end
  end

  def test_chaining_on_parent_that_does_not_respond_to_setting_name_raises_an_error
    setting = Cerulean::SettingConfiguration.new(:bad_chain, type: :string)
    model = BasicModel.new
    assert model.respond_to?(:bad_parent_method), 'Basic model does not respond to bad_parent_method'
    processor = Cerulean::ActiveRecord::Processor.new(model)
    assert_raises Cerulean::InvalidChain do
      processor.fetch(setting, parent: :bad_parent_method, mode: :resolve)
    end
  end
end
