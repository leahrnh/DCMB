module DevLogin
  def self.included(base)
    base.instance_eval do
      prepend_before_filter :authenticate_if_dev_mode
    end
  end
  
  def authenticate_if_dev_mode
    authenticate if dev?
  end
end