# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SubmenuExtension < Radiant::Extension
  version "0.1"
  description "Adds handy submenus to tabs in the radiant admin navigation"
  url "http://spanner.org/radiant/submenu"
  
  define_routes do |map|
    map.namespace :admin do |admin|
      admin.resources :submenu_links
    end
  end

  def activate
    Radiant::AdminUI::Tab.send :include, TabExtensions
    Radiant::AdminUI.send :include, Submenu
    ApplicationHelper.send :include, Admin::SubmenuHelper
    ApplicationController.send :include, ResourceControllerExtensions

    unless defined? admin.submenu_links
      Radiant::AdminUI.send :include, SubmenuAdminUI
      admin.submenu_link = Radiant::AdminUI.load_default_submenu_link_regions
    end

  end
  
  def deactivate
  end
  
end
