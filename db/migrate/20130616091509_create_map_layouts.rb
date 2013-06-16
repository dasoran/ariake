class CreateMapLayouts < ActiveRecord::Migration
  def change
    create_table :map_layouts do |t|
      t.references :event, null: false
      t.references :comiket_block, null: false
      t.integer :space_number, null: false
      t.integer :x, null: false
      t.integer :y, null: false
      t.integer :layout, null: false
      t.timestamps
    end
    add_index :map_layouts, :comiket_block_id
    add_index :map_layouts, :space_number
    add_index :map_layouts, :event_id
  end
end
