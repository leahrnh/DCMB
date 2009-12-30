module DevLogin
  def self.included(base)
    base.class_eval do
      unless login_required?
        prepend_before_filter :authenticate_for_dev_mode
      end
    end
  end
  
  ##
  # Requires authentication for any page requests in SiteController when in dev mode
  def authenticate_for_dev_mode
    if dev?
      authenticate
    end
  end
end