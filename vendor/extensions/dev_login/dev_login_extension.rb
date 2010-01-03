# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class DevLoginExtension < Radiant::Extension
  version "1.0"
  description "Requires login for viewing dev mode pages."
  url "http://blog.aughr.com/radiant-dev-login-extension"
  
  def activate
    SiteController.send :include, DevLogin
  end
end
