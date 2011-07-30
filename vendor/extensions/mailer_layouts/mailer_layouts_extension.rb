# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class MailerLayoutsExtension < Radiant::Extension
  version "1.0"
  description "Allows the use of radiant layouts in email messages"
  url "http://github.com/spanner/radiant-mailer_layouts-extension"
    
  def activate
    require 'mailer_layouts'
    MessagePage
    ActionView::Base.send :include, MailerHelper
  end
end
