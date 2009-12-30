require File.dirname(__FILE__) + '/../spec_helper'
 
describe SiteController do
  dataset :pages
  
  it "should require login in dev mode" do
    request.host = "dev.site.com"
    lambda { get :show_page, :url => '/' }.should require_login
  end
end