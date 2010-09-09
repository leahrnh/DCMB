module GroupedForum

  def self.included(base)
    base.class_eval {
      is_grouped
      gives_group_to :topics  # which in turn give it to posts
    }
  end

end
