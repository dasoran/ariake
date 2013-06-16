class CreateComiketAreas < ActiveRecord::Migration
  def change
    create_table :comiket_areas do |t|
      t.string :name, null: false
      t.string :map_e_w, null: false
      t.integer :map_id, null: false
      t.timestamps
    end
  end
end
