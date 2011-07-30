class ForumsGroups < ActiveRecord::Migration
  def self.up
    create_table :forums_groups, :id => false do |t|
      t.column :forum_id, :integer
      t.column :group_id, :integer
    end
  end

  def self.down
    drop_table :forums_groups
  end
end
