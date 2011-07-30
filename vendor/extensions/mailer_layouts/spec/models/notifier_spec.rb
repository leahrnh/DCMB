require File.dirname(__FILE__) + '/../spec_helper'

class NotifierWithRadiantLayout < ActionMailer::Base
  radiant_layout 'email'
end

class NotifierWithRadiantLayoutBlock < ActionMailer::Base
  radiant_layout {|c| c.action_name == "index" ? "main" : "utf8" }
end

class Notifier < ActionMailer::Base
  radiant_layout "email"

  def normal(recipient)
    from "someone@spanner.org"
    subject "normal"
    recipients recipient
    content_type "text/html"
    body({
      :message => "This is a test"
    })
  end

  def custom(recipient, layout)
    from "someone@spanner.org"
    subject "custom"
    recipients recipient
    message_layout layout
    content_type layout.content_type
    body({
      :message => "This is also a test"
    })

  end
end

describe NotifierWithRadiantLayout do  
  dataset :mailer_layouts
  
  it "should have a default_layout attribute" do
    NotifierWithRadiantLayout.read_inheritable_attribute(:default_layout).should == 'email'
  end
end
  
describe NotifierWithRadiantLayoutBlock do  
  dataset :mailer_layouts
  
  it "should have default_layout block" do
    NotifierWithRadiantLayoutBlock.read_inheritable_attribute(:default_layout).should be_kind_of(Proc)
  end
end

describe Notifier do  
  dataset :mailer_layouts
  
  describe "sending a normal message" do
    it "should apply the default layout" do
      message = Notifier.create_normal("anyone@all.com")
      message.should_not be_nil
      message.body.should =~ /Rendered via mailer_layout:/          # test that radiant_layout has been applied at all
      message.body.should =~ /Normal email layout/                  # test that the right radiant layout has been applied
      message.body.should =~ /Normal message template./             # test that the right message template has been used
      message.body.should =~ /This is a test/                       # test that the @message variable has made it through
      message.content_type.should == 'text/html'
    end
  end

  describe "sending a custom message" do
    it "should apply its own layout" do
      message = Notifier.create_custom("anyone@all.com", layouts(:custom))
      message.should_not be_nil
      message.body.should =~ /Rendered via mailer_layout:/
      message.body.should =~ /Custom email layout/
      message.body.should =~ /Custom message template./
      message.body.should =~ /This is also a test/
      message.content_type.should == 'text/html'
    end
  end

  describe "using a plain text layout" do
    it "should set the right content-type" do
      message = Notifier.create_custom("anyone@all.com", layouts(:plain))
      message.content_type.should == 'text/plain'
    end
  end

end

