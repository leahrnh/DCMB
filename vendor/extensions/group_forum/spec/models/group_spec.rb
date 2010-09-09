require File.dirname(__FILE__) + '/../spec_helper'

describe Group do
  dataset :group_forum_forums
  
  before do
    @site = Page.current_site = sites(:test) if defined? Site
  end
  
  it "should have a forums association" do
    Group.reflect_on_association(:forums).should_not be_nil
  end

  it "should have a list of forums" do
    group = groups(:chatty)
    group.forums.any?.should be_true
    group.forums.size.should == 2
  end

end
