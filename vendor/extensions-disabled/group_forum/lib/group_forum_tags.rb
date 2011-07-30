module GroupForumTags
  include Radiant::Taggable
  
  class TagError < StandardError; end

  desc %{
    Expands if this group has any forums.
    
    <pre><code><r:group:if_forums>...</r:group:if_forums></code></pre>
  }
  tag "group:if_forums" do |tag|
    tag.expand if tag.locals.group.forums.any?
  end

  desc %{
    Expands if this group does not have any forums.
    
    <pre><code><r:group:unless_forums>...</r:group:unless_forums></code></pre>
  }
  tag "group:unless_forums" do |tag|
    tag.expand unless tag.locals.group.forums.any?
  end

  desc %{
    Expands if this group has any topics.
    
    <pre><code><r:group:if_topics>...</r:group:if_topics></code></pre>
  }
  tag "group:if_topics" do |tag|
    tag.expand if tag.locals.group.topics.any?
  end

  desc %{
    Expands if this group does not have any topics.
    
    <pre><code><r:group:unless_topics>...</r:group:unless_topics></code></pre>
  }
  tag "group:unless_topics" do |tag|
    tag.expand unless tag.locals.group.topics.any?
  end

  desc %{
    Loops through the forums belonging to this group.
    
    <pre><code><r:group:forums:each>...</r:group:forums:each /></code></pre>
  }
  tag "group:forums" do |tag|
    tag.locals.forums = tag.locals.group.forums
    tag.expand
  end
  tag "group:forums:each" do |tag|
    result = []
    tag.locals.forums.each do |forum|
      tag.locals.forum = forum
      result << tag.expand
    end
    result
  end

  desc %{
    Loops through the latest topics in all forums belonging to this group.
    
    <pre><code><r:group:latest_topics:each count="10">...</r:group:latest_topics:each></code></pre>
  }
  tag "group:latest_topics" do |tag|
    count = tag.attr["count"] || 10
    tag.locals.topics = tag.locals.group.topics.latest(count)
    tag.expand
  end
  tag "group:latest_topics:each" do |tag|
    result = []
    tag.locals.topics.each do |topic|
      tag.locals.topic = topic
      result << tag.expand
    end
    result
  end

  desc %{
    If the group has only one forum, this presents a simple new-topic link around the supplied text. 
    If it has several forums, this offers a list with the supplied text as the heading.
    
    <pre><code><r:group:new_topic_link /></code></pre>
  }
  tag "group:new_topic_link" do |tag|
    forums = tag.locals.group.forums
    text = tag.double? ? tag.expand : "Start a new conversation"
    result = ""
    case forums.length
    when 0
    when 1
      result << %{<a href="#{new_forum_topic_path(forums.first)}">#{text}</a>}
    else
      result << %{<h3>#{text}</h3><ul>}
      result << forums.collect{|forum| %{<li><a href="#{new_forum_topic_path(forum)}">#{forum.name}</a></li>}}
      result << "</ul>"
    end
    result
  end

end
