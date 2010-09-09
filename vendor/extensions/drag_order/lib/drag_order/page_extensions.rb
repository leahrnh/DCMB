module DragOrder::PageExtensions
  def self.included(base)
    base.class_eval {
      self.reflections[:children].options[:order] = "position ASC"
      
      def self.children_of_after_position(parent, position)
        find_all_by_parent_id(parent, :conditions => [ 'position >= ?', position ])
      end
      
      def self.children_of_with_slug_like(parent, slug)
        find_all_by_parent_id(parent, :conditions => [ 'slug LIKE ?', slug ])
      end
      
      before_validation_on_create :set_initial_position
    }
    
    if defined?(Page::NONDRAFT_FIELDS)
      Page::NONDRAFT_FIELDS << 'position'
    end
  end

  def newly_created_siblings?
    self.class.find_all_by_parent_id(parent_id, :conditions => ["position is null"] ).size > 0
  end
  
  def siblings_and_self
    self.class.find_all_by_parent_id(parent_id, :order => ["position ASC"] )
  end
  
  def following_siblings
    self.class.find_all_by_parent_id(parent_id, :conditions => [ 'position > ?', position ] )
  end

private
  def set_initial_position
    self.position ||= begin
      if last_sibling = Page.find_by_parent_id(parent_id, :order => [ "position DESC" ])
        last_sibling.position + 1
      else
        0
      end
    end
  end
end
