module AssetPlayerHelper
      
  def player_for(asset)
    if asset.playable?
      include_javascript 'swfobject' 
      url = asset.asset.url
      width = "100%"
      version = "9.0.0"
      height = asset.movie? ? 327 : 27
      result = %{
<div id="player_#{asset.id}" class="player"><p class="failure">You probably need to run <tt>rake radiant:extensions:paperclipped_player:update</tt></p></div>
<script type="text/javascript">
  //<![CDATA[
    mpw_vars = {
      backcolor: "ffffff",
      frontcolor: "4d4e53",
      autoplay: "false"
    };
      }
      if asset.video?
        result << %{
    mpw_vars['flv'] = "#{url}";
    mpw_vars['fullscreen'] = "true";
        }
      else
        result << %{
    mpw_vars['mp3'] = "#{url}";
    mpw_vars['fullscreen'] = "false";
        }
      end
      result << %{
    swfobject.embedSWF("/flash/mpw_player.swf", "player_#{asset.id}", "#{width}", "#{height}", "#{version}", "/flash/expressInstall.swf", mpw_vars); 
  //]]>
</script>
      }
    end
  end
  
end
