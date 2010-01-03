require File.dirname(__FILE__) + '/../spec_helper'

describe SubmenuLink do
  dataset :submenu_links
  
  it "should return the right set of links for a given user" do
    links = SubmenuLink.visible_to(users(:existing))
    links.include?(submenu_links(:news)).should be_true
    links.include?(submenu_links(:assets)).should be_true
    links.include?(submenu_links(:personal)).should be_false
    SubmenuLink.visible_to(users(:another)).include?(submenu_links(:personal)).should be_true
  end
  
  describe "instantiated" do
    before do
      @link = submenu_links(:news)
    end
    
    it "should require a name" do
      @link.name = nil
      @link.valid?.should be_false
    end
    
    it "should require a url" do
      @link.url = ""
      @link.valid?.should be_false
    end
    
    it "should be global by default" do
      @link.global?.should be_true
    end
    
    it "should be personal if it has a user" do
      submenu_links(:personal).global?.should be_false
    end
    
  end
  
end
