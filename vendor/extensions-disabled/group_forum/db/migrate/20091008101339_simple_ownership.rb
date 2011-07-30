class SimpleOwnership < ActiveRecord::Migration
  def self.up
    drop_table :forums_groups
    add_column :forums, :group_id, :integer
    add_column :topics, :group_id, :integer
    add_column :posts, :group_id, :integer
  end

  def self.down
    remove_column :forums, :group_id
    remove_column :topics, :group_id
    remove_column :posts, :group_id
    create_table :forums_groups, :id => false do |t|
      t.column :forum_id, :integer
      t.column :group_id, :integer
    end
  end
end
