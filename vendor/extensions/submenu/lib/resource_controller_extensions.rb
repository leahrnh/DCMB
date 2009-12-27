module ResourceControllerExtensions
  
  def self.included(base)
    base.class_eval {
      alias_method_chain :set_javascripts_and_stylesheets, :submenu
    }
  end
  
  def set_javascripts_and_stylesheets_with_submenu
    set_javascripts_and_stylesheets_without_submenu
    @stylesheets << 'admin/submenu'
    @javascripts << 'admin/submenu'
  end

end
  