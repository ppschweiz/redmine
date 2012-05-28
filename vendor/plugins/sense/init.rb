require 'placeholders'
require 'redmine'

require_dependency 'google_adsense_hook'

RAILS_DEFAULT_LOGGER.info 'Starting Google AdSense Plugin for Redmine'

Redmine::Plugin.register :sense_plugin do
    name 'Google AdSense'
    author 'Andriy Lesyuk'
    author_url 'http://www.andriylesyuk.com'
    description 'Allows to specify custom HTML code for different places on site.'
    url 'http://projects.andriylesyuk.com/projects/redmine-google-ads'
    version '0.0.1'

    menu :admin_menu, :google_adsense,
                    { :controller => 'google_adsense', :action => 'index' },
                      :caption => :label_google_adsense,
                      :after => :enumerations
end
