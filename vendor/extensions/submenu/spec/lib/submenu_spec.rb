require File.dirname(__FILE__) + "/../spec_helper"

describe Radiant::AdminUI do
  it "should include SubMenu" do
    Radiant::AdminUI.included_modules.should include(Submenu)
  end
end

describe Radiant::AdminUI::SubmenuLink do
  it "should be defined" do
    defined?(Radiant::AdminUI::SubmenuLink).should be_true
  end
  
  describe "instantiated" do
    before :each do
      @link = Radiant::AdminUI::SubmenuLink.new('sna', 'foo')
    end
    
    it "should have a name" do
      @link.name.should == 'sna'
    end
    
    it "should have a url" do
      @link.url.should == 'foo'
    end
  end
end

describe Radiant::AdminUI::Submenu do
  it "should be defined" do
    defined?(Radiant::AdminUI::Submenu).should be_true
  end
  
  describe "instantiated" do
    before :each do
      @submenu = Radiant::AdminUI::Submenu.new
    end
    
    it "should be empty" do
      @submenu.has_links?.should be_false
    end
    
    it "should be able to add a link" do
      @submenu.add('foo', 'bar')
      @submenu.has_links?.should be_true
    end
    
    describe "with links" do
      before do
        @submenu.add('sna', 'foo')
        @submenu.add('foo', 'bar')
      end
      
      it "should respond correctly to []" do
        @submenu['foo'].url.should == 'bar'
      end
    
      it "should respond correctly to size" do
        @submenu.size.should == 2
      end
    
      it "should respond correctly to each" do
        text = ''
        @submenu.each {|l| text << l.url }
        text.should == 'foobar'
      end
    
      it "should be able to remove a link" do
        @submenu.remove('foo')
        @submenu.size.should == 1
        @submenu['sna'].should_not be_nil
        @submenu['foo'].should be_nil
      end
    
      it "should respond correctly to clear" do
        @submenu.clear
        @submenu.has_links?.should be_false
      end
    end
  end
end

