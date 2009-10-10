module Admin::SubmenuHelper

  def self.included(base)
    base.class_eval do

      def links_for_navigation_with_submenu
        links_for_navigation_without_submenu + navigation_submenu
      end
      alias_method_chain :links_for_navigation, :submenu

      def navigation_submenu
        links = []
        set_links = navigation_submenu_links
        current_tab = admin.tabs.find{ |tab| current_url?(urlize_path(tab.url)) }
        if current_tab && current_tab.has_submenu?
          current_tab.submenu.each do |link| 
            links << nav_link_to(link.name, urlize_path(link.url))
          end
          %{<div id="submenu">#{set_links}<div>#{links.join(separator)}</div></div>}
        elsif set_links
          %{<div id="submenu">#{set_links}</div>}
        else
          %{<div id="submenu" class="empty"></div>}
        end
      end
      
      # these are the non-tab-related links added on a per-site or per-user basis through the admin interface
      
      def navigation_submenu_links
        links = SubmenuLink.visible_to(current_user).map {|link| link_to(link.name, urlize_path(link.url)) }
        links << link_to("edit menu", admin_submenu_links_url, :class => 'admin') if admin?
        %{<div id="submenu_links">#{links.join(separator)}</div>} if links.any?
      end

      def urlize_path(url)
        File.join(ActionController::Base.relative_url_root || '', url)
      end

    end
  end

  
end