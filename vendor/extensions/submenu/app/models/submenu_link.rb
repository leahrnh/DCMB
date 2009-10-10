class SubmenuLink < ActiveRecord::Base

  is_site_scoped if defined? ActiveRecord::SiteNotFound

  belongs_to :user
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  validates_presence_of :name, :url

  named_scope :visible_to, lambda { |user|
    { :conditions => ["user_id = ? or user_id IS NULL", user.id] }
  }

  def global?
    !user
  end

end
