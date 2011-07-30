module MailerLayouts
  def self.included(base)
    base.extend ClassMethods
    base.class_eval {
      adv_attr_accessor :message_layout                   # instance method to set individual message layout

      # the radiant_layout class method will store a default in :mailer_layout_name
      # during ActionMailer initialization we instantiate that and store that in an instance variable 
      # (having called it, if it's a proc)
      # Note that individual messages you can override this by calling the instance method
      #   radiant_layout(Layout object)
      # during message instantiation (alongside subject, recipients, etc)

      def initialize_defaults_with_layout(method_name)
        initialize_defaults_without_layout(method_name)
        default_layout = self.class.read_inheritable_attribute :default_layout
        default_layout = default_layout.call(self) if default_layout.is_a? Proc
        @message_layout = Layout.find_by_name(default_layout)
      end
      alias_method_chain :initialize_defaults, :layout
    }
  end
  
  module ClassMethods
    def radiant_layout(name=nil, options={}, &block)        # class method to set default radiant layout
      raise ArgumentError, "A layout name or block is required!" unless name || block
      write_inheritable_attribute :default_layout, name || block

      # radiant_mailer is an actual layout file in app/layouts/radiant_mailer.html.haml
      # but all it does is call the mailer_layout method defined in MailerHelper
      # and pass to it the necessary instance variables.
      layout 'radiant_mailer', options
    end
  end
end

ActionMailer::Base.send :include, MailerLayouts
