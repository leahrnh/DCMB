# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class PaperclippedPlayerExtension < Radiant::Extension
  version "0.3"
  description "Adds audio and video player tags to paperclipped and some useful conditionals around them"
  url "http://spanner.org/radiant/paperclipped_player"
  
  extension_config do |config|
    config.gem 'paperclip'
    config.extension 'paperclipped'
  end

  def activate
    AssetType.new :playable, :mime_types => AssetType.mime_types_for(:audio, :video)
    Page.send :include, AssetPlayerTags
    Admin::AssetsController.send :helper, AssetPlayerHelper
  end

end
