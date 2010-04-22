ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'medias'
  map.connect '/play/*file', :controller => 'medias', :action => 'play'
  map.connect '/*folder', :controller => 'medias', :action => 'index'
end
