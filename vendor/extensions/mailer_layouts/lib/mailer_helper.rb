module MailerHelper
  
  def apply_radiant_layout(mailer_ivars = {})
    message = MessagePage.new(:class_name => "MessagePage")
    layout = mailer_ivars[:@message_layout]
    layout = Layout.find_by_name(layout) unless layout.is_a? Layout
    message.layout = layout 
    message.title = @title || @content_for_title || message.title || ''
    message.build_parts_from_hash!(extract_captures)
    message.mailer_vars = mailer_ivars
    message.render
  end
      
  def extract_captures
    variables = instance_variables.grep(/@content_for_/)
    variables.inject({}) do |h, var|
      var =~ /^@content_for_(.*)$/
      key = $1.intern
      key = :body if key == :layout
      h[key] = instance_variable_get(var) unless key == :title
      h
    end
  end
  
end
