class SidebarHook  < Redmine::Hook::ViewListener

    def helper_projects_settings_tabs(context = {})
        if User.current.allowed_to?(:manage_sidebar, context[:project])
            context[:tabs].push({ :name => 'sidebar',
                                  :action => :manage_sidebar,
                                  :partial => 'projects/settings/sidebar',
                                  :label => :label_sidebar })
        end
    end

    render_on :view_projects_show_sidebar_bottom, :partial => 'sidebar/project'
    render_on :view_issues_sidebar_issues_bottom, :partial => 'sidebar/issues'
    render_on :view_layouts_base_sidebar,         :partial => 'sidebar/base'

end
