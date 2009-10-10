require File.dirname(__FILE__) + "/../spec_helper"

describe Radiant::AdminUI::Tab do
  it "should include TabExtensions" do
    Radiant::AdminUI::Tab.included_modules.should include(TabExtensions)
  end
  
  describe "instantiated" do
    before :each do
      @tab = Radiant::AdminUI::Tab.new('sna', 'foo')
    end
    
    it "should have a submenu object" do
      @tab.submenu.should_not be_nil
    end
    
    it "should report that it has no menu links" do
      @tab.has_submenu?.should be_false
    end
    
    it "should be able to add a link" do
      @tab.add_link('foo', 'bar')
      @tab.has_submenu?.should be_true
    end
    
    describe "with links" do
      before do
        @tab.add_link('sna', 'foo')
        @tab.add_link('foo', 'bar')
      end

      it "should be able to remove a link" do
        @tab.remove_link('foo')
        @tab.submenu.size.should == 1
        @tab.submenu['sna'].should_not be_nil
        @tab.submenu['foo'].should be_nil
      end
    end
  end
  
  describe "an existing tab" do
    before do
      @admin = Radiant::AdminUI.instance
    end
    
    it "should have no submenu links" do
      @admin.tabs['Snippets'].has_submenu?.should be_false
    end
    
    it "should be able to add a submenu item" do
      @admin.tabs['Snippets'].add_link('sna', 'foo')
      @admin.tabs['Snippets'].has_submenu?.should be_true
      @admin.tabs['Snippets'].submenu['sna'].url.should == 'foo'
    end
  end
end
