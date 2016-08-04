require 'test_helper'

class Cerulean::ActiveRecordModelTest < Minitest::Test
  Cerulean::Engine.load(path: File.expand_path("../../config/cerulean_settings.rb", __FILE__))
  require 'schema'
  require 'models'

  def test_model_uses_configuration_column
    assert_equal Cerulean::ActiveRecordModel::DEFAULT_CONFIGURATION_COLUMN, BasicModel.cerulean_configuration_column
    assert_equal 'prefs', CustomColumnModel.cerulean_configuration_column
    assert_equal Cerulean::ActiveRecordModel::DEFAULT_CONFIGURATION_COLUMN, JsonColumnModel.cerulean_configuration_column
  end

  def test_model_resonds_to_getters
    [
      BasicModel.new,
      JsonColumnModel.new,
      CustomColumnModel.new
    ].each do |model|
      %w(string_setting integer_setting boolean_setting).each do |s|
        assert model.respond_to?(s.to_sym)
      end
    end
  end

  def test_model_resonds_to_setters
    [
      BasicModel.new,
      JsonColumnModel.new,
      CustomColumnModel.new
    ].each do |model|
      %w(string_setting integer_setting boolean_setting).each do |s|
        assert model.respond_to?("#{s}=".to_sym)
      end
    end
  end

  def test_new_sets_the_settings
    attrs = { string_setting: 'string', integer_setting: 2, boolean_setting: true }
    [
      BasicModel.new(attrs),
      JsonColumnModel.new(attrs),
      CustomColumnModel.new(attrs)
    ].each do |model|
      assert_equal 'string', model.string_setting
      assert_equal 2, model.integer_setting
      assert_equal true, model.boolean_setting
    end
  end

  def test_create_sets_the_settings
    attrs = { string_setting: 'string', integer_setting: 2, boolean_setting: true }
    [
      BasicModel.create!(attrs),
      JsonColumnModel.create!(attrs),
      CustomColumnModel.create!(attrs)
    ].each do |model|
      assert_equal 'string', model.string_setting
      assert_equal 2, model.integer_setting
      assert_equal true, model.boolean_setting
    end
  end

  def test_update_attributes_updates_the_settings
    [
      BasicModel.new,
      JsonColumnModel.new,
      CustomColumnModel.new
    ].each do |model|
      assert_equal nil, model.string_setting
      assert_equal nil, model.integer_setting
      assert_equal nil, model.boolean_setting
      model.update_attributes!(string_setting: 'string', integer_setting: 2, boolean_setting: true)
      assert_equal 'string', model.string_setting
      assert_equal 2, model.integer_setting
      assert_equal true, model.boolean_setting
    end
  end
end
