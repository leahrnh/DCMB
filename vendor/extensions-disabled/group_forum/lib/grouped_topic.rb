module GroupedTopic

  def self.included(base)
    base.class_eval {
      is_grouped
      gets_group_from :forum
      gives_group_to :posts
    }
  end

end
