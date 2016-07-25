module Cerulean
  class Engine
    class ConfigReader
      def config(name, type, options = {})
        setting = ConfigSetting.new(name, type, options)
        Engine.register_setting setting
      end
    end

    def self.known_settings
      @known_settings ||= {}
    end

    def self.load(path: 'config/cerulean_settings.rb')
      raise ConfigurationNotFound, "No such file '#{path}'" unless File.exist?(path)
      clear_settings
      ConfigReader.new.instance_eval(File.read(path))
    end

    def self.register_setting(setting)
      known_settings[setting.name] = setting
    end

    def self.clear_settings
      @known_settings = {}
    end
  end
end
