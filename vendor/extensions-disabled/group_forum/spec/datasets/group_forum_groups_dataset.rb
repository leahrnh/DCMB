require 'digest/sha1'
class GroupForumGroupsDataset < Dataset::Base
  datasets = [:group_forum_readers]
  datasets << :group_forum_sites if defined? Site
  uses *datasets

  def load
    create_group "Normal"
    create_group "Chatty"

    add_readers_to_group :chatty, [:normal, :another]
  end
  
  helpers do
    def create_group(name, att={})
      group = create_record Group, name.symbolize, group_attributes(att.update(:name => name))
    end
    
    def group_attributes(att={})
      name = att[:name] || "A group"
      attributes = { 
        :name => name,
        :description => "Test group"
      }.merge(att)
      attributes[:site_id] ||= site_id(:test) if defined? Site
      attributes
    end
  end
    
  def add_readers_to_group(g, rr)
    g = groups(g) unless g.is_a?(Group)
    g.readers << rr.map{|r| readers(r)}
  end

end