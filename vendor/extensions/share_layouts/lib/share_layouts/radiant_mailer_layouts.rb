module ShareLayouts::RadiantMailerLayouts
  def self.included(base)
    base.extend ClassMethods
    base.class_eval {
      adv_attr_accessor :message_layout

      # the radiant_layout class method stores a default layout name in default_radiant_mailer_layout_name
      # during initialization we call the stored default layout name (if it's a proc) 
      # and then put it in the mailer's @message_layout instance variable
      # where the mailer can let the individual message override it

      def initialize_defaults_with_layout(method_name)
        default_layout = self.class.read_inheritable_attribute 'default_radiant_mailer_layout_name'
        default_layout = default_layout.call(self) if default_layout.is_a? Proc
        initialize_defaults_without_layout(method_name)
        @message_layout ||= Layout.find_by_name(default_layout)
        
      end
      alias_method_chain :initialize_defaults, :layout

      include InstanceMethods
    }
  end
  
  module ClassMethods
    def radiant_layout(name=nil, options={}, &block)
      raise ArgumentError, "A default layout name or block is required!" unless name || block
      write_inheritable_attribute 'default_radiant_mailer_layout_name', name || block
      layout 'radiant_mailer', options
    end
  end
    
  module InstanceMethods
    
    # default_radiant_mailer_layout_name is often a proc that calls default_layout_for:
    
    def default_layout_for(purpose = :email)
      # Reader defines site.layout_for
      if defined? Site && current_site && current_site.respond_to?(:layout_for)
        current_site.layout_for(purpose)
      elsif config_layout = Radiant::Config["#{purpose}.layout"]
        config_layout
      else
        'email'
      end
    end
  end
end

ActionMailer::Base.send :include, ShareLayouts::RadiantMailerLayouts
