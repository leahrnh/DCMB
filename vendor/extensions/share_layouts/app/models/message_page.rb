class MessagePage < Page
  display_name "Not really a page at all"

  def find_by_url(url, live=true, clean=true)
    self
  end
  
  def build_parts_from_hash!(content)
    content.each do |k,v|
      (part(k) || parts.build(:name => k.to_s, :filter_id => "")).content = v
    end
  end 
  
end