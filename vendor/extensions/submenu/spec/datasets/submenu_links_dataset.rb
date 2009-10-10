require 'digest/sha1'

class SubmenuLinksDataset < Dataset::Base
  datasets = [:users, :pages]
  datasets << :submenu_sites if defined? Site
  uses *datasets
  
  def load
    create_link "news", :url => "/admin/pages/#{page_id(:news)}/children/new"
    create_link "assets", :url => "/admin/assets/uploader"
    create_link "personal", :url => "/admin/pages/#{page_id(:party)}/children/new", :user_id => user_id(:another)
  end
  
  helpers do
    def create_link(name, attributes)
      attributes = link_attributes(attributes.update(:name => name))
      create_model SubmenuLink, name.symbolize, attributes
    end
    
    def link_attributes(attributes={})
      name = attributes[:name] || "Link"
      attributes = { 
        :url => "#",
        :user_id => nil
      }.merge(attributes)
      attributes[:site] = sites(:test) if defined? Site
      attributes
    end    
  end
 
end