xml.channel do
  xml.atom :link, nil, {
    :href => formatted_posts_url(:rss),
    :rel => 'self', :type => 'application/rss+xml'
  }

  xml.title "#{@site_title} : Latest posts"
  xml.description "Latest posts in any topic or forum"
  xml.link posts_url
  xml.language "en-us"
  xml.ttl "60"

  render :partial => "post", :collection => @posts, :locals => {:xm => xml}
end
