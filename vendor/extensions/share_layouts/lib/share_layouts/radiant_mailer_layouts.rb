module ShareLayouts::RadiantMailerLayouts
  def self.included(base)
    base.extend ClassMethods
    base.class_eval {
      include InstanceMethods
      alias_method_chain :initialize_defaults, :layout
    }
  end
  
  module ClassMethods
    def radiant_layout(name=nil, options={}, &block)
      raise ArgumentError, "A layout name or block is required!" unless name || block
      write_inheritable_attribute 'radiant_mailer_layout_name', name || block
      layout 'radiant_mailer', options
    end
  end
    
  module InstanceMethods
    
    # no callbacks in ActionMailer
    def initialize_defaults_with_layout(method_name)
      @layout_loaded = true
      initialize_defaults_without_layout(method_name)
      @radiant_mailer_layout = self.class.read_inheritable_attribute 'radiant_mailer_layout_name'
      @radiant_mailer_layout = @radiant_mailer_layout.call(self) if @radiant_mailer_layout.is_a? Proc
    end

    def layout_for(purpose = :email)
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
