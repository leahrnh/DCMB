require 'digest/sha1'
class GroupForumReadersDataset < Dataset::Base
  uses :group_forum_sites if defined? Site

  def load
    create_reader "Normal"
    create_reader "Another"
    create_reader "Ungrouped"
  end
  
  helpers do
    def create_reader(name, attributes={})
      attributes = reader_attributes(attributes.update(:name => name))
      reader = create_model Reader, name.symbolize, attributes
    end
    
    def reader_attributes(attributes={})
      name = attributes[:name] || "John Doe"
      symbol = name.symbolize
      attributes = { 
        :name => name,
        :email => "#{symbol}@spanner.org", 
        :login => "#{symbol}@spanner.org",
        :activated_at => Time.now - 1.week,
        :password_salt => "golly",
        :password => 'password',
        :password_confirmation => 'password'
      }.merge(attributes)
      attributes[:site] = sites(:test) if defined? Site
      attributes
    end
  end
 
end