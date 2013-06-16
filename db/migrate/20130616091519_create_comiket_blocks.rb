class CreateComiketBlocks < ActiveRecord::Migration
  def change
    create_table :comiket_blocks do |t|
      t.references :comiket_area, null: false
      t.string :name, null: false
      t.timestamps
    end
    add_index :comiket_blocks, :comiket_area_id
  end
end
