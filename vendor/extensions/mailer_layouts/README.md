# Mailer Layouts

This is equivalent the the `share_layouts` extension but for email messages: it extends ActionMailer to support the rendering of email messages within a radiant layout. It is deliberately minimal and does not include any notification or mailmerge functionality. Its purpose is to make that functionality possible without any assumption as to how it will be used.

You can use radius tags and `content_for` blocks in your message templates and they will work as usual provided they don't expect a request or response object.

`Share_layouts` is not required, but can be used alongside this extension.

## Status

Newly extracted from our fork of `share_layouts`. This code has been in use for a couple of years but it's slightly revised here so bugs are possible. 

ActionMailer is nasty inside and relies heavily on instance variables that we have to set from the outside, so if there are bugs they tend to be a bit obscure.

## Todo

Set `message.content_type` automatically to `layout.content_type`.

## Installation

	# gem install radiant-mailer_layouts-extension
	
and in environment.rb:

	config.gem "radiant-mailer_layouts-extension"
	
or for integration with older projects:

	git submodule add git://github.com/spanner/radiant-mailer_layouts-extension.git vendor/extensions/mailer_layouts

## Usage

Set the layout name in your notifier class:

	class UserNotifier < ActionMailer::Base
	  radiant_layout 'email'

or pass a proc to decide later:

	  radiant_layout {|m| m.choose_layout_at_runtime}
  
	  def choose_layout_at_runtime
	    Radiant::Config['mailer.layout'] || 'email'
	  end
	
You can also set layout for each message by calling the message_layout setter directly:

	radiant_layout :default_email
	
	def admonish(user)
  	  subject "bad user! bad!"
	  recipients user.email
	  message_layout "angry"
	  ...
	end
	
Note that the instance method will overrule the default layout name set by the class method, but it requires that class declaration has been used first to bring in the necessary machinery.

## Configuration

Make sure this extension loads before any that defines Notifiers, such as `reader`. Here's one I use quite often:

	config.extensions = [ :layouts, :mailer_layouts, :reader, :all, :library ]


## Copyright

William Ross for spanner, 2008-2010

Released under the same terms as radiant and/or rails.