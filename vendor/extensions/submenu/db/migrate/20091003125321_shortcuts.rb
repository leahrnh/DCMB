class Shortcuts < ActiveRecord::Migration
  def self.up
    create_table "submenu_links" do |t|
      t.column :name, :string
      t.column :url, :string
      t.column :user_id, :integer
      t.column :site_id, :integer
      t.column :created_by_id, :integer
      t.column :updated_by_id, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
    add_index "submenu_links", ["site_id", "user_id"], :name => "index_links_by_site_and_user"
  end

  def self.down
    drop_table "submenu_links"
  end
end
