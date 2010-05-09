# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class ShareLayoutsExtension < Radiant::Extension
  version "0.3.1"
  description "Allows Radiant layouts to be used as layouts for standard Rails actions."
  url "http://wiki.github.com/radiant/radiant/thirdparty-extensions"
  
  # I'm sure this can be done more elegantly, but without it, RSpec complains about routing errors
  if ENV["RAILS_ENV"] == "test"
    define_routes do |map|
      map.connect ':controller/:action/:id'
    end
  end

  def activate
    require 'share_layouts/radiant_layouts'
    require 'share_layouts/radiant_mailer_layouts'
    
    RailsPage
    ActionView::Base.send :include, ShareLayouts::Helper
    ApplicationController.send :include, ShareLayouts::ControllerExtensions
  end
  
  def deactivate
  end
  
end
