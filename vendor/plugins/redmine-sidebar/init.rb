require 'redmine'
require 'dispatcher'

require_dependency 'sidebar_hook'

RAILS_DEFAULT_LOGGER.info 'Starting Sidebar Content Plugin for Redmine'

Dispatcher.to_prepare :sidebar_plugin do
    unless ActionView::Base.included_modules.include?(SidebarContentHelper)
        ActionView::Base.send(:include, SidebarContentHelper)
    end
    unless ProjectsController.included_modules.include?(SidebarProjectsControllerPatch)
        ProjectsController.send(:include, SidebarProjectsControllerPatch)
    end
end

Redmine::Plugin.register :sidebar_plugin do
    name 'Sidebar content'
    author 'Andriy Lesyuk'
    author_url 'http://www.facebook.com/andriy.lesyuk'
    description 'Specify sidebar content per project.'
    url 'http://labs.softjourn.com/projects/redmine-sidebar'
    version '0.0.3'

    permission :manage_sidebar, { :sidebar => [ :edit, :preview ] }, :require => :member
end
