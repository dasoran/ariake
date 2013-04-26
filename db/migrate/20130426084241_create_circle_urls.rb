class CreateCircleUrls < ActiveRecord::Migration
  def change
    create_table :circle_urls do |t|
      t.references :circle, null: false
      t.text :url, null: false
      t.string :attribute, null: false, default: "web"
      t.timestamps
    end
    add_index :circle_urls, :circle_id
  end
end
