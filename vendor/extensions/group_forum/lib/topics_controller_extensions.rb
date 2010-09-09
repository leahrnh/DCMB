module TopicsControllerExtensions
  
  def self.included(base)
    base.class_eval {
      before_filter :require_visibility_of_forum_and_page

    protected
      
      def require_visibility_of_forum_and_page
        if @page && !@page.visible_to?(current_reader)
          flash[:error] = "Sorry: you don't have permission to see that page."
          redirect_to reader_permission_denied_url
          return false
        end
        if @forum && !@forum.visible_to?(current_reader)
          flash[:error] = "Sorry: you don't have permission to see that discussion."
          redirect_to reader_permission_denied_url
          return false
        end
      end
    }
  end
end



