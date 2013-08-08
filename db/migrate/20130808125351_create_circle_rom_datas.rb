class CreateCircleRomDatas < ActiveRecord::Migration
  def change
    create_table :circle_rom_datas do |t|
      t.integer :rom_id, null: false
      t.integer :page, null: false
      t.integer :cut_index, null: false
      t.string :attend, null: false
      t.references :map_layout, null: false
      t.integer :genre_code, null: false
      t.string :circle_name, null: false
      t.string :circle_name_kana, null: false
      t.string :author, null: false
      t.string :book_name, null: false
      t.string :url
      t.string :mail
      t.string :comment
      t.string :appended_comment
      t.string :circlems_url
      t.string :rss_url
      t.timestamps
    end
  end
end
