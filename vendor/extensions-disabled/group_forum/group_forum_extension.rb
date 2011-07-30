class GroupForumExtension < Radiant::Extension
  version "0.3"
  description "Just a bit of access-control glue joining reader_groups to forum"
  url "http://spanner.org/radiant/group_forums"

  extension_config do |config|
    config.extension 'forum'
    config.extension 'reader_group'
  end
  
  def activate
    Forum.send :include, GroupedForum
    Topic.send :include, GroupedTopic
    Post.send :include, GroupedPost
    Page.send :include, GroupForumTags          # a few tags for listing forums and latest topics on group pages

    ForumsController.send :include, ForumsControllerExtensions
    TopicsController.send :include, TopicsControllerExtensions
    PostsController.send :include, PostsControllerExtensions

    unless admin.forum.edit.form && admin.forum.edit.form.include?("forum_group")
      admin.forum.edit.add :form, "forum_group"
    end
  end
  
  def deactivate
  end
  
end
