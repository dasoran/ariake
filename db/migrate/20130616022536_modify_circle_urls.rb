class ModifyCircleUrls < ActiveRecord::Migration
  def up
    add_column :circle_urls, :is_master_url, :boolean
  end

  def down
    remove_column :circle_urls, :is_master_url
  end
end
