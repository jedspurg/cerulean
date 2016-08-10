require 'test_helper'

class Cerulean::SettingConfigurationTest < Minitest::Test
  def setup
    @name     = 'some_name'
    @type     = Cerulean::SettingConfiguration::VALID_TYPES.first
    @chain_on = Cerulean::SettingConfiguration::CHAINING_OPTIONS.first
    @default  = 1
  end

  def test_setting_configuration_only_needs_name_and_type_and_sets_defaults
    setting = Cerulean::SettingConfiguration.new(@name, @type)
    assert_equal @name, setting.name
    assert_equal @type.to_sym, setting.type
    assert_equal :blank, setting.chain_on
    assert_equal nil, setting.default
    assert_equal [], setting.validations
  end

  def test_requires_valid_type
    assert_raises Cerulean::InvalidType do
      Cerulean::SettingConfiguration.new(@name, 'invalid_type')
    end

    Cerulean::SettingConfiguration::VALID_TYPES.each do |type|
      setting = Cerulean::SettingConfiguration.new(@name, type)
      assert_equal type, setting.type
    end
  end

  def test_chain_on_must_be_valid
    assert_raises Cerulean::InvalidChainOption do
      Cerulean::SettingConfiguration.new(@name, @type, chain_on: :bad_chain_on)
    end

    Cerulean::SettingConfiguration::CHAINING_OPTIONS.each do |chain_on|
      setting = Cerulean::SettingConfiguration.new(@name, @type, chain_on: chain_on)
      assert_equal chain_on, setting.chain_on
    end
  end

  def test_sets_default_value
    setting = Cerulean::SettingConfiguration.new(@name, @type, default: @default)
    assert_equal @default, setting.default
  end

  def test_sets_validations_to_array
    validation = { presence: true }
    setting = Cerulean::SettingConfiguration.new(@name, @type, validations: validation)
    assert setting.validations.is_a?(Array)
    assert_equal [validation], setting.validations

    setting = Cerulean::SettingConfiguration.new(@name, @type, validations: [validation])
    assert setting.validations.is_a?(Array)
    assert_equal [validation], setting.validations
  end
end
