require 'test_helper'
require 'ostruct'

class Cerulean::EngineTest < Minitest::Test
  def setup
    @setting_name = :setting_name
    @mock_setting = OpenStruct.new(name: @setting_name)
  end

  def teardown
    Cerulean::Engine.clear_settings
  end

  def test_engine_holds_list_of_known_settings
    assert Cerulean::Engine.known_settings.is_a?(Hash)
  end

  def test_engine_registers_a_setting
    Cerulean::Engine.register_setting(@mock_setting)
    refute Cerulean::Engine.known_settings[@setting_name].nil?
    assert_equal @mock_setting, Cerulean::Engine.known_settings[@setting_name]
  end

  def test_engine_can_clear_known_settings
    Cerulean::Engine.register_setting(@mock_setting)
    Cerulean::Engine.clear_settings
    assert_equal Hash.new, Cerulean::Engine.known_settings
  end
end
