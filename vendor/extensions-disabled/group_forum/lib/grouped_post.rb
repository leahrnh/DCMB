module GroupedPost

  def self.included(base)
    base.class_eval {
      is_grouped
      gets_group_from :topic
    }
  end

end
