ActionController::Routing::Routes.draw do |map|
    map.connect('projects/:id/download', :controller => 'download', :action => 'edit', :conditions => { :method => :post })
end
