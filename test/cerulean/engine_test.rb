require 'test_helper'
require 'ostruct'
require 'tempfile'

class Cerulean::EngineTest < Minitest::Test
  def setup
    Cerulean::Engine.clear_settings
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

  def test_load_reads_a_file_and_stores_settings
    file = Tempfile.new(['cerulean-settings', '.rb'])
    File.open(file.path, 'w') do |f|
      f.write("setting :#{@setting_name}_1, :string\n")
      f.write("setting :#{@setting_name}_2, :string\n")
    end
    Cerulean::Engine.load(path: file.path)
    assert_equal 2, Cerulean::Engine.known_settings.size
    refute Cerulean::Engine.known_settings["#{@setting_name}_1".to_sym].nil?
    refute Cerulean::Engine.known_settings["#{@setting_name}_2".to_sym].nil?
  ensure
    if file.respond_to?(:close)
      file.close
      file.unlink
    end
  end

  def test_loads_if_file_is_not_found
    assert_raises Cerulean::SettingFileNotFound do
      Cerulean::Engine.load(path: 'non-existant-path.rb')
    end
    assert_equal 0, Cerulean::Engine.known_settings.size
  end
end
