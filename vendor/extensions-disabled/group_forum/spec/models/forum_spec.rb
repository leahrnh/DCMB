require File.dirname(__FILE__) + '/../spec_helper'

describe Forum do
  dataset :group_forum_forums
  
  before do
    @site = Page.current_site = sites(:test) if defined? Site
  end
  
  it "should have a group association" do
    Forum.reflect_on_association(:group).should_not be_nil
  end
  
  it "should normally list only the ungrouped forums" do
    Forum.visible.count.should == 1
  end

  describe "with a group" do
    it "should report itself visible to a reader who is a group member" do
      forums(:grouped).visible_to?(readers(:normal)).should be_true
    end
    it "should report itself invisible to a reader who is not a group member" do
      forums(:grouped).visible_to?(readers(:ungrouped)).should be_false
    end
  end

  describe "without a group" do
    it "should report itself visible to everyone" do
      forums(:public).visible_to?(readers(:normal)).should be_true
      forums(:public).visible_to?(readers(:ungrouped)).should be_true
    end
  end
end
