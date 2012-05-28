module Google
    module AdSense
        Placeholders = YAML.load_file("#{File.dirname(__FILE__)}/../config/placeholders.yml")
    end
end

Google::AdSense::Placeholders.each do |hook,placeholder|
    placeholder['hook'] = hook
end
