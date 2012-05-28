ActionController::Routing::Routes.draw do |map|
    map.connect('google_adsense/load', :controller => 'google_adsense', :action => 'load')
    map.connect('google_adsense/update', :controller => 'google_adsense', :action => 'update')
    map.connect('google_adsense/:hook', :controller => 'google_adsense', :action => 'index')
end
