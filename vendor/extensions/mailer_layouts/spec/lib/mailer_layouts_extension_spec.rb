require File.dirname(__FILE__) + '/../spec_helper'

describe MailerLayoutsExtension do
    
  it "should initialize" do
    MailerLayoutsExtension.root.should == File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'mailer_layouts')
    MailerLayoutsExtension.extension_name.should == 'Mailer Layouts'
  end
  
  it "should add mailer hooks" do
    ActionMailer::Base.should respond_to(:radiant_layout)
    ActionMailer::Base.instance_methods.include?('initialize_defaults_with_layout').should be_true
  end
  
  it "should add helper" do
    ActionView::Base.included_modules.include?(MailerHelper).should be_true
  end
end
