module ForumsControllerExtensions
  
  def self.included(base)
    base.class_eval {
      before_filter :require_visibility_of_forum

      def index
        @forums = Forum.visible_to(current_reader).paginate(:all, :order => "position", :page => params[:page] || 1, :per_page => params[:per_page])    #nb. visible_to is a named_scope defined in GroupedModel (in reader_group)
      end

    protected
      
      def require_visibility_of_forum
        if @forum && !@forum.visible_to?(current_reader)
          flash[:error] = "Sorry: you don't have permission to see that discussion category."
          redirect_to reader_permission_denied_url
          return false
        end
      end
    }
  end
end
