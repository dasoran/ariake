class CreateHandouts < ActiveRecord::Migration
  def change
    create_table :handouts do |t|
      t.references :entry, null: false
      t.references :goods, null: false
      t.timestamps
    end
    add_index :handouts, :entry_id
    add_index :handouts, :goods_id
  end
end
