require 'redmine'
require 'dispatcher'

require_dependency 'extended_profile_hook'

RAILS_DEFAULT_LOGGER.info 'Starting Extended Profile plugin for Redmine'

Dispatcher.to_prepare :extended_profile_plugin do
    unless WikiController.included_modules.include?(CustomFieldsHelper)
        WikiController.send(:helper, :custom_fields)
        WikiController.send(:include, CustomFieldsHelper)
    end
end

Redmine::Plugin.register :extended_profile_plugin do
    name 'Extended profile'
    author 'Andriy Lesyuk'
    author_url 'http://www.andriylesyuk.com'
    description 'Adds many new fields to user profile.'
    url 'http://projects.andriylesyuk.com/projects/redmine-profile'
    version '1.0.0'
end
