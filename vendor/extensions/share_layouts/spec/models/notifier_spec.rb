require File.dirname(__FILE__) + '/../spec_helper'

class NotifierWithRadiantLayout < ActionMailer::Base
  radiant_layout 'main'
end

class NotifierWithRadiantLayoutBlock < ActionMailer::Base
  radiant_layout {|c| c.action_name == "index" ? "main" : "utf8" }
end

class Notifier < ActionMailer::Base
  radiant_layout { |m| m.default_layout_for :test }
  
  def test(recipient="test@spanner.org")
    from "someone@spanner.org"
    subject "test"
    recipients recipient
    content_type "text/html"
  end
end

describe NotifierWithRadiantLayout do  
  dataset :layouts
  
  it "should have radiant layout attribute" do
    NotifierWithRadiantLayout.read_inheritable_attribute('default_radiant_mailer_layout_name').should == 'main'
  end
end
  
describe NotifierWithRadiantLayoutBlock do  
  dataset :layouts
  
  it "should have radiant layout block" do
    NotifierWithRadiantLayoutBlock.read_inheritable_attribute('default_radiant_mailer_layout_name').should be_kind_of(Proc)
  end
end

describe Notifier do  
  dataset :layouts
  
  before(:each) do
    Radiant::Config['test.layout'] = 'utf8'
  end
    
  it "should apply the radiant layout" do
    message = Notifier.create_test("anyone@all.com")
    message.should_not be_nil
    message.body.should =~ /Rendered with the mailer_layout:/
    message.body.should =~ /Test message template./
    message.content_type.should == 'text/html'
  end
end

