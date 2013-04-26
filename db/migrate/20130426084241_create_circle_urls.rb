class CreateCircleUrls < ActiveRecord::Migration
  def change
    create_table :circle_urls do |t|
      t.references :circle, null: false
      t.text :page_url, null: false
      t.string :page_attr, null: false, default: "web"
      t.timestamps
    end
    add_index :circle_urls, :circle_id
  end
end
