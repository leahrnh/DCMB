module Admin::SubmenuHelper

  def self.included(base)
    base.class_eval do

      def links_for_navigation_with_submenu
        %{
          <div id="navigation_tabs">#{links_for_navigation_without_submenu}</div>
          #{navigation_submenu}
        }
      end
      alias_method_chain :links_for_navigation, :submenu

      def navigation_submenu
        standard_links = site_chooser + navigation_submenu_links
        if current_tab && current_tab.has_submenu?
          tab_links = current_tab.submenu.select{|link| link.shown_for?(current_user)}.map{|link| submenu_link_to(link.name, urlize_path(link.url)) }.join(separator)
        end
        %{<div id="submenu">#{standard_links}<div id="tabmenu">#{tab_links}</div></div>}
      end

      # these are the non-tab-related links added on a per-site or per-user basis through the admin interface

      def navigation_submenu_links
        links = SubmenuLink.visible_to(current_user).map {|link| link_to(link.name, urlize_path(link.url)) }
        links << link_to("edit menu", admin_submenu_links_url, :class => 'admin') if admin?
        if links.any?
          %{<div id="submenu_links">#{links.join(separator)}</div>}
        else
          ""
        end
      end

      def submenu_link_to(name, url)
        if current_link?(url)
          %{<strong>#{ link_to name, url }</strong>}
        else
          link_to name, url
        end
      end

      # we introduce the tab match rather than going straight to the url match so that special cases can be applied

      def current_tab
        @current_tab ||= admin.tabs.sort{ |a,b| b.url.length <=> a.url.length }.find{ |tab| current_url?(urlize_path(tab.url)) }
      end

      def current_tab?(url)
        url = clean(url)
        current_tab && url =~ /#{current_tab.url}/
      end

      def current_link
        @current_link ||= current_tab.submenu.sort{ |a,b| b.url.length <=> a.url.length }.find{ |link| exactly_current_url?(urlize_path(link.url)) }
      end

      def current_link?(url)
        url = clean(url)
        current_link && url == current_link.url
      end

      def current_url?(url)
        requested_url = modify_url_for_special_cases(request.request_uri)
        requested_url =~ Regexp.new('^' + Regexp.quote(clean(url)))
      end

      def exactly_current_url?(url)
        request.request_uri =~ Regexp.new('^' + Regexp.quote(clean(url)))
      end

      def modify_url_for_special_cases(url)
         url.gsub(/\/admin\/(css|js)/, '/admin/pages')
      end

      # and under multi_site this builds a site-chooser whenever the foreground model is site_scoped
      # (the defined?(controller) check is an extra bodge to make tests pass)

      def site_chooser
        return "" unless admin? && defined?(Site) && defined?(controller) && controller.sited_model? && controller.template_name == 'index' && Site.several?
        options = Site.find(:all).map{ |site| "<li>" + link_to( site.name, "#{request.path}?site_id=#{site.id}", :class => site == current_site ? 'fg' : '') + "</li>" }
        chooser = %{<div id="site_chooser">}
        chooser << link_to("sites", admin_sites_url, {:id => 'show_site_list', :class => 'expandable'})
        chooser << %{<ul class="expansion" id="site_list">#{options}</ul>}
        chooser << %{</div>}
        chooser
      end

      def urlize_path(url)
        File.join(ActionController::Base.relative_url_root || '', url)
      end


    end
  end
end