require 'test_helper'

class Cerulean::ActiveRecordModelTest < Minitest::Test
  Cerulean::Engine.load(path: File.expand_path("../../config/cerulean_settings.rb", __FILE__))
  require 'schema'
  require 'models'

  def test_model_resonds_to_getters
    model = BasicModel.new
    %w(string_setting integer_setting boolean_setting).each do |s|
      assert model.respond_to?(s.to_sym)
    end
  end

  def test_model_resonds_to_setters
    model = BasicModel.new
    %w(string_setting integer_setting boolean_setting).each do |s|
      assert model.respond_to?("#{s}=".to_sym)
    end
  end

  def test_new_sets_the_settings
    model = BasicModel.new(string_setting: 'string', integer_setting: 2, boolean_setting: true)
    assert_equal 'string', model.string_setting
    assert_equal 2, model.integer_setting
    assert_equal true, model.boolean_setting
  end

  def test_create_sets_the_settings
    model = BasicModel.create!(string_setting: 'string', integer_setting: 2, boolean_setting: true)
    assert_equal 'string', model.string_setting
    assert_equal 2, model.integer_setting
    assert_equal true, model.boolean_setting
  end

  def test_update_attributes_updates_the_settings
    model = BasicModel.new
    assert_equal nil, model.string_setting
    assert_equal nil, model.integer_setting
    assert_equal nil, model.boolean_setting
    model.update_attributes!(string_setting: 'string', integer_setting: 2, boolean_setting: true)
    assert_equal 'string', model.string_setting
    assert_equal 2, model.integer_setting
    assert_equal true, model.boolean_setting
  end
end
