class SidebarController < ApplicationController
    before_filter :find_project
    before_filter :find_sidebar_content
    before_filter :authorize

    def edit
        if params[:sidebar][:content_type].present?
            if @sidebar
                if @sidebar.update_attributes(params[:sidebar])
                    flash[:notice] = l(:notice_successful_update)
                else
                    flash[:error] = @sidebar.errors.full_messages.join(', ')
                end
            else
                attrs = params[:sidebar].dup
                @sidebar = SidebarContent.new(attrs.merge(:project => @project))
                if @sidebar.save
                    flash[:notice] = l(:notice_successful_create)
                else
                    flash[:error] = @sidebar.errors.full_messages.join(', ')
                end
            end
        else
            if @sidebar && @sidebar.destroy
                flash[:notice] = l(:notice_successful_delete)
            end
        end
        redirect_to(:controller => 'projects', :action => 'settings', :tab => 'sidebar', :sidebar => params[:sidebar]) # FIXME: use remote form + update
    end

    def preview
        if params[:sidebar]
            @previewed = @sidebar
            case params[:sidebar][:content_type]
            when 'text'
                @text = params[:sidebar][:content] ? params[:sidebar][:content][:text] : nil
                render(:partial => 'common/preview')
            when 'wiki'
                page = @project && @project.wiki && params[:sidebar][:content] ?
                       @project.wiki.find_page(params[:sidebar][:content][:wiki]) : nil
                @text = ''
                if page
                    @text = page.text
                end
                render(:partial => 'common/preview')
            when 'html'
                html = '<fieldset class="preview">'
                html << '<legend>' + l(:label_preview) + '</legend>'
                if params[:sidebar][:content]
                    html << params[:sidebar][:content][:html]
                end
                html << '</fieldset>'
                render(:text => html)
            else
                render_403
            end
        end
    end

private

    def find_project
        @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render_404
    end

    def find_sidebar_content
        @sidebar = SidebarContent.find_by_project_id(@project.id)
    end

end
