module Cerulean
  class Engine
    class SettingReader
      def setting(name, type, options = {})
        Engine.register_setting ConfigSetting.new(name, type, options)
      end
    end

    def self.known_settings
      @known_settings ||= {}
    end

    def self.load(path: 'config/cerulean_settings.rb')
      raise SettingFileNotFound, "No such file '#{path}'" unless File.exist?(path)
      clear_settings
      SettingReader.new.instance_eval(File.read(path))
    end

    def self.register_setting(setting)
      known_settings[setting.name.to_sym] = setting
    end

    def self.clear_settings
      @known_settings = {}
    end
  end
end
